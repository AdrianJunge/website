---
title: Photoeditor
author: Adrian Junge
description: Recently I learned ASP .NET Core and boy, it's so magic! Dependency injection, dynamic routing, interfaces everywhere. But for me, it wasn't dynamic enough. So I extended the framework and now I got all the dynamic in the world I could wish for. That surely didn't introduce any vulnerabilities, right?",
categories:
    - Web
    - .NET
year: 2024
---

# 1. Introduction<a name="introduction"></a>
This challenge was about some interesting dynamic implementation to process user generated input calling appropriate functions in the application:

```
Recently I learned ASP .NET Core and boy, it's so magic!
Dependency injection, dynamic routing, interfaces everywhere.
But: For me, it wasn't dynamic enough.
So I extended the framework and now I got all the dynamic in the world I could wish for.
That surely didn't introduce any vulnerabilities, right?
```


# 2. Reconnaissance<a name="reconnaissance"></a>
Looking around on the webpage you have access to, you can play around uploading some pictures and editing these with special options.

![rickroll](ctf/writeups/cscg/photoeditor/rick.png "rickroll")

Uploading pictures is usually very interesting by giving a nice attack surface. But having a look at the **C#** code you realize the picture is never uploaded as a file to the server. It is just getting cached in the memory and there being modified directly. Looking through the source files one of them looks very interesting. One of the controllers is executing some bash command with arbitrarily set environment variables. This might be useful later, although just being able to execute `whoami` doesn’t seem that interesting at first...


```C#
public String GetUsername(Dictionary<String,String> env) {
    Process process = new Process();
    process.StartInfo.FileName = "bash";
    process.StartInfo.Arguments = "-c 'whoami'";

    foreach (var kv in evn)
    {
        process.StartInfo.EnvironmentVariables[kv.Key] = kv.Value;
    }

    process.StartInfo.UseShellExecute = false;
    process.StartInfo.RedirectStandardOutput = true;
    process.StartInfo.RedirectStandardError = true;
    process.Start();
    string output = process.StandardOutput.ReadToEnd();
    Console.WriteLine(output);
    string err = process.StandardError.ReadToEnd();
    Console.WriteLine(err);
    process.WaitForExit();

    return output + err;
}
```

By having a closer look at the rest of your code the `DynamicPhotoEditorController` seems very interesting. This controller defines the editing process of the image. The chosen editing action is part of the request and is being processed in an interesting way.

```C#
var actionMethod = this.GetType().GetMethod(photoTransferRequestModel.DynamicAction);
```

After some deserialization of the given request parameters the given action method is called with the request parameters.

```C#
var transformedImage = (Image)actionMethod.Invoke(this, editParams);
```

Definitely a way to make your application very dynamic – but also very vulnerable... These lines of code just takes the `DynamicAction` request parameter, maps it to an arbitrary method of the controller, and executes it. For example, rotating the image is done with the following request parameters:

![dynamicaction](ctf/writeups/cscg/photoeditor/rotateimage_req.png "dynamicaction")


# 3. Vulnerability Description<a name="vulnerability description"></a>
At first, it seems like there are no interesting functions to call but taking a closer look at the code you realize the `DynamicPhotoEditorController` is inheriting from the `BaseAPIController` which implements the `GetUsername` function. So maybe you can call this one and make the application execute `whoami`? The given `DynamicAction` is not being sanitized and validated by the server. By setting `DynamicAction` to `GetUsername` you get:

![dynamicaction](ctf/writeups/cscg/photoeditor/dynamicaction_res.png "dynamicaction")

Although it is just throwing an error hinting some issues with converting some types, this seems promising. It seems like it is having problems calling the `GetUsername` function because the parameter got the wrong type. There is an example usage of the `GetUsername` function in the `HealthController`. By setting the `Types` field to `System.Collections.Generic.Dictionary'2[System.String,System.String]` and the `Parameters` field for the environment variables correctly:

![getusername](ctf/writeups/cscg/photoeditor/getusername_req.png "getusername")

you unfortunately get another error:

![getusername](ctf/writeups/cscg/photoeditor/getusername_res.png "getusername")

But having another look on the code it seems like the `whoami` command must have been executed. This error must be part of the editor controller. Right after calling the action method, the result is converted to `Image`.

```C#
var transformedImage = (Image)actionMethod.Invoke(this, editParams);
```

But what now?


# 4. Exploitation<a name="exploitation"></a>
Only being able to execute some hard-coded commands like `whoami` and being able to set the environment variables can’t be enough for RCE right? But indeed it is enough! After searching for some weird bash environment variables I found something interesting. By setting `BASH_FUNC_whoami%%=() { id; }` you could override the behavior of the `whoami` command executing for example the `id` command. By setting the request parameters like following:

![getusername-flag-req](ctf/writeups/cscg/photoeditor/getusername_flag_req.png "getusername-flag-req")

you can extract the flag to your request bin

![pastebin](ctf/writeups/cscg/photoeditor/flag_pastebin.png "pastebin")

There are some other solutions with different bash environment variables like `BASH_ENV` and `LD_PRELOAD`.


# 5. Mitigation<a name="mitigation"></a>
This is clearly a problem of the implementation. At least some input sanitization and validation of the `DynamicAction` parameter should have been added like limiting the allowed character, length etc. But input validation should never be the only security measurement. With some weird edge cases an attacker could still bypass it. Another option would be some kind of static mapping from parameter to function. Moreover executing shell commands via the code is a bad idea. There are most of the time safe built-in functions in **C#** doing the same job. Also setting the environment variables dynamically can lead to security issues as already described. Setting the environment variables should be part of the deployment e.g. in a docker container and not part of the code.


# 6. Flag<a name="flag"></a>
CSCG\{AppSec\_Chall3nge\_disguised\_as\_W3b\_sorry:)\}
