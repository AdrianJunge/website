module TerminalHelper
  def render_terminal(paths, minimized)
    paths = [ "~", ".", ".." ] + paths
    terminal_class = "subpixel-antialiased font-mono bg-black"
    terminal_class += " terminal-minimized" if minimized
    content_tag(:div, id: "terminal-container", data: { terminal_text: paths.to_json }, class: terminal_class) do
      content_tag(:div, class: "terminal-header") do
        safe_join([
          content_tag(:div, id: "minimize-terminal", class: "terminal-button") do
            image_tag("terminal/minimize-icon.svg", alt: "Minimize", class: "button-icon")
          end,
          content_tag(:div, id: "maximize-terminal", class: "terminal-button") do
            image_tag("terminal/maximize-icon.svg", alt: "Maximize", class: "button-icon")
          end,
          content_tag(:div, id: "close-terminal", class: "terminal-button") do
            image_tag("terminal/close-icon.svg", alt: "Close", class: "button-icon")
          end
        ])
      end
    end
  end
end
