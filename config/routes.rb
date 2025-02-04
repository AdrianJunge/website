Rails.application.routes.draw do
  root "landing#index"

  get "/ctf", to: "ctf#index"
  get "/ctf/:which", to: "ctf#which"
  get "/ctf/:which/:writeup", to: "ctf#writeup"
end
