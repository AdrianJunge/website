Rails.application.routes.draw do
  root "landing#index"
  get "/ctf/files/*file_path", to: "ctf_files#download", as: :ctf_file_download
  get "/ctf", to: "ctf#index"
  get "/ctf/:which", to: "ctf#which"
  get "/ctf/:which/:writeup", to: "ctf#writeup"
end
