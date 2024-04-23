Rails.application.routes.draw do
  root "animais#index"

  get  "login", to: "sessions#new"
  post "login", to: "sessions#create"
  # get  "sign_up", to: "registrations#new"
  # post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  # namespace :identity do
  #   resource :email,              only: [:edit, :update]
  #   resource :email_verification, only: [:show, :create]
  #   resource :password_reset,     only: [:new, :edit, :create, :update]
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :especies, except: [:show]
  resources :recintos, except: [:show]

  resources :animais, except: [:show]
  patch "animais/:id/activation_animal", to: "animais#activation_animal", as: "activation_animal"
  get "animais/:id/historic", to: "animais#historic", as: "historicos_animal"
  get "animais/:id/edit_status_animal", to: "animais#edit_status_animal", as: "edit_status_animal"
  patch "animais/:id/update_status_animal", to: "animais#update_status_animal", as: "update_status_animal"
end
