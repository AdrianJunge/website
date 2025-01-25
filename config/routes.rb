Rails.application.routes.draw do
  root "landing#index"

  get "/about_me", to: "about_me#index"
  get "/contact", to: "contact#index"

  get "/ctf", to: "ctf#index"
  get "/ctf/:which", to: "ctf#which"
  get "/ctf/:which/:writeup", to: "ctf#writeup", constraints: { writeup: /.+\.md/ }
end
