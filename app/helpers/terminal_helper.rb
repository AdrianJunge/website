module TerminalHelper
  TAG = "adrian@my-space:~$"
  TAG_COLOR = "text-red-700"

  def render_terminal(commands_and_outputs, minimized)
    terminal_class = "subpixel-antialiased font-mono"
    terminal_class += " terminal-minimized" if minimized
    content_tag(:div, id: "terminal", class: terminal_class) do
      safe_join([
        render_terminal_top,
        content_tag(:div, class: "terminal-content") do
          safe_join([
            render_commands(commands_and_outputs),
            last_terminal_input
          ])
        end
      ])
    end
  end

  def render_terminal_command(command)
    content_tag(:div, class: "mt-4 flex") do
      render_terminal_input(command)
    end
  end

  def render_terminal_input(command)
    safe_join([
      content_tag(:span, TAG, class: TAG_COLOR),
      content_tag(:p, class: "pl-2") do
        content_tag(:span, command, class: "typing-command")
      end
    ])
  end


  private

  def last_terminal_input
    content_tag(:div, id: "terminal-last-input", class: "mt-4 flex", style: "visibility: hidden") do
      safe_join([
        content_tag(:span, TAG, class: TAG_COLOR),
        content_tag(:p, class: "pl-2") do
          content_tag(:span, "", class: "last-typing-command")
        end
      ])
    end
  end

  def render_commands(commands_and_outputs)
    safe_join(
      commands_and_outputs.map do |command_with_output|
        render_terminal_command(command_with_output[:command]) +
        render_terminal_output(command_with_output[:outputs])
      end
    )
  end

  def render_terminal_top
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



  def render_terminal_output(outputs)
    content_tag(:div, class: "mt-4 pl-2 text-left") do
      safe_join(
        outputs.map do |output|
          content_tag(:span, output.html_safe, class: "command-output", style: "visibility: hidden") +
          tag.br
        end
      )
    end
  end
end
