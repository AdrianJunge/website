module SidebarHelper
  def taskbar_icon_item(image_path:, alt_text:, label:, link: nil, icon_class:, label_class:, id: nil, target: nil)
    content_tag :div, class: "taskbar-item" do
      if link
        concat(link_to(image_tag(image_path, alt: alt_text, class: icon_class, id: id), link, target: target))
      else
        concat(image_tag(image_path, alt: alt_text, class: icon_class, id: id))
      end
      concat(content_tag(:span, label, class: label_class))
    end
  end

  def render_taskbar_items(taskbar_items)
    taskbar_icon_class = "taskbar-icon bg-tertiary hover:bg-accent hover:scale-110"
    taskbar_label_class = "taskbar-label"

    content_tag(:div, id: "taskbar-left", class: "bg-primary collapsed") do
      concat(content_tag(:div, class: "taskbar-items-upper") do
        concat(content_tag(:div, class: "taskbar-item") do
          image_tag("task-bar/burgermenu.svg", alt: "Home Icon", class: taskbar_icon_class, id: "menu-icon")
        end)
        concat(taskbar_icon_item(
          image_path: "task-bar/home.svg",
          alt_text: "Home Icon",
          label: "Home",
          link: root_path,
          icon_class: taskbar_icon_class,
          label_class: taskbar_label_class
        ))
        taskbar_items.each do |item|
          concat(taskbar_icon_item(
            image_path: item[:image_path],
            alt_text: item[:alt_text],
            label: item[:label],
            link: item[:link],
            icon_class: taskbar_icon_class,
            label_class: taskbar_label_class
          ))
        end
      end)

      concat(content_tag(:div, class: "taskbar-items-mid") do
        concat(taskbar_icon_item(
          image_path: "task-bar/terminal.svg",
          alt_text: "Terminal Icon",
          label: "Terminal navigation",
          icon_class: taskbar_icon_class,
          label_class: taskbar_label_class,
          id: "terminal-taskbar-icon"
        ))
      end)

      concat(content_tag(:div, class: "taskbar-items-lower") do
        concat(taskbar_icon_item(
          image_path: "task-bar/github.svg",
          alt_text: "Github Icon",
          label: "Github",
          link: "https://github.com/AdrianJunge/",
          icon_class: taskbar_icon_class,
          label_class: taskbar_label_class,
          target: "_blank"
        ))
        concat(taskbar_icon_item(
          image_path: "task-bar/linkedin.svg",
          alt_text: "Linkedin Icon",
          label: "Linkedin",
          link: "https://www.linkedin.com/in/adrian-junge-998a63296/",
          icon_class: taskbar_icon_class,
          label_class: taskbar_label_class,
          target: "_blank"
        ))
        concat(taskbar_icon_item(
          image_path: "task-bar/discord.svg",
          alt_text: "Discord Icon",
          label: "Discord",
          link: "https://discord.com/users/305624492221267968",
          icon_class: taskbar_icon_class,
          label_class: taskbar_label_class,
          target: "_blank"
        ))
      end)
    end
  end
end
