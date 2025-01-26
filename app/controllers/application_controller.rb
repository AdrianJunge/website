class ApplicationController < ActionController::Base
  before_action :set_global_variable
  allow_browser versions: :modern

  private

  def set_global_variable
    @paths_color = "text-blue-400"
    @current_time = Time.now.strftime("%b %d %H:%M")
  end
end
