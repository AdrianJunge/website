Rails.application.routes.draw do
  root "landing#index"
  get "landing/phone", to: "landing#phone"

  post "terminal/render_command", to: "terminal#render_command"
end
