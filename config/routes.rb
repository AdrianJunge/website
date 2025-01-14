Rails.application.routes.draw do
  resources :ctf
  resources :bug_bounty
  resources :resumes, only: [ :index ]
  resources :minigames, only: [ :index ]
  resources :tools, only: [ :index ]
  resources :blog_posts, only: [ :index, :show ]

  root "pages#home"
end
