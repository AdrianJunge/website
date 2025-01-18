Rails.application.routes.draw do
  root "landing#index"

  get "ctf", to: "landing#ctf"
  get "bug-bounty", to: "landing#bug_bounty"
  get "cv", to: "landing#cv"
  get "minigames", to: "landing#minigames"
  get "tools", to: "landing#tools"
  get "blog", to: "landing#blog"
end
