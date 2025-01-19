module TerminalHelper
  def render_terminal(command, paths, current_time)
    content_tag(:div, class: "coding inverse-toggle px-5 pt-4 shadow-lg text-gray-100 text-3xl font-mono subpixel-antialiased bg-gray-700 pb-6 pt-4 rounded-lg leading-normal", style: "width: 1200px; max-width: 90%; white-space: nowrap;") do
      safe_join([
        render_terminal_top,
        render_terminal_command(command),
        render_terminal_paths(paths, current_time)
      ])
    end
  end

  private

  def render_terminal_top
    content_tag(:div, class: "top mb-2 flex") do
      safe_join([
        content_tag(:div, "", class: "h-3 w-3 bg-red-500 rounded-full"),
        content_tag(:div, "", class: "ml-2 h-3 w-3 bg-orange-300 rounded-full"),
        content_tag(:div, "", class: "ml-2 h-3 w-3 bg-green-500 rounded-full")
      ])
    end
  end

  def render_terminal_command(command)
    content_tag(:div, class: "mt-4 flex") do
      safe_join([
        content_tag(:span, "adrian@computer:~$", class: "text-blue-400"),
        content_tag(:p, class: "pl-2") do
          content_tag(:span, command, class: "typing-command")
        end
      ])
    end
  end

  def render_terminal_paths(paths, current_time)
    content_tag(:div, class: "mt-4 pl-2 text-left") do
      safe_join(
        paths.map do |path|
          content_tag(:span, "drwxr-xr-x  5 adrian adrian  4.0K #{current_time} #{path}", class: "text-blue-400", style: "visibility: hidden") +
          tag.br
        end
      )
    end
  end
end
