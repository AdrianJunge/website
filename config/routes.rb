Rails.application.routes.draw do
  root "landing#index"

  get "/ctf", to: "ctf#index"
  get "/about_me", to: "about_me#index"
end
