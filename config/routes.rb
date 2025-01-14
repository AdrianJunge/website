Rails.application.routes.draw do
  root "pages#home" # Startseite
  get "ctf", to: "ctf#index"
  get "bug_bounty", to: "bug_bounty#index"
  get "resume", to: "resume#index"
  get "minigames", to: "minigames#index"
  get "tools", to: "tools#index"
  get "blog", to: "blog#index"
end
