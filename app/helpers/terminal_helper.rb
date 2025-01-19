module TerminalHelper
  def render_terminal(commands_and_outputs)
    content_tag(:div, id: "terminal", class: "coding inverse-toggle px-5 pt-4 shadow-lg text-gray-100 text-3xl font-mono subpixel-antialiased bg-gray-700 pb-6 pt-4 rounded-lg leading-normal", style: "width: 1200px; max-width: 90%; white-space: nowrap;") do
      safe_join([
        render_terminal_top,
        render_commands(commands_and_outputs),
        last_terminal_input
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
      content_tag(:span, "adrian@computer:~$", class: "text-blue-400 computer"),
      content_tag(:p, class: "pl-2") do
        content_tag(:span, command, class: "typing-command")
      end
    ])
  end


  private

  def last_terminal_input
    content_tag(:div, id: "terminal-last-input", class: "mt-4 flex", style: "visibility: hidden") do
      safe_join([
        content_tag(:span, "adrian@computer:~$", class: "text-blue-400 computer"),
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
    content_tag(:div, class: "top mb-2 flex") do
      safe_join([
        content_tag(:div, "", class: "h-3 w-3 bg-red-500 rounded-full"),
        content_tag(:div, "", class: "ml-2 h-3 w-3 bg-orange-300 rounded-full"),
        content_tag(:div, "", class: "ml-2 h-3 w-3 bg-green-500 rounded-full")
      ])
    end
  end

  def render_terminal_output(outputs)
    content_tag(:div, class: "mt-4 pl-2 text-left") do
      safe_join(
        outputs.map do |output|
          content_tag(:span, output, class: "text-blue-400", style: "visibility: hidden") +
          tag.br
        end
      )
    end
  end
end
