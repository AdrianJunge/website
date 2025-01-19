Rails.application.routes.draw do
  root "landing#index"
  get "landing/phone", to: "landing#phone"
end
