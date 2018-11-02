Rails.application.routes.draw do
  root "home#index"

  devise_for :users, skip: [:sessions]
  devise_scope :user do
    get    "signup",  to: "devise/registrations#new"
    post   "signup",  to: "devise/registrations#create"
    get    "signin",  to: "devise/sessions#new"
    post   "signin",  to: "devise/sessions#create"
    delete "signout", to: "devise/sessions#destroy"
  end

  resources :green_acts
end
