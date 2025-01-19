class TerminalController < ApplicationController
  include TerminalHelper

  def render_command
    command = params[:command]
    html = render_to_string(partial: "shared/terminal_command", locals: { command: command })
    render json: { html: html }
  end
end
