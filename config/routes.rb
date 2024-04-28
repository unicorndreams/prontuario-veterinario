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

  resources :animais, except: [:show] do
    collection do
      get :limpar_filtro
    end
  end

  namespace :animais do
    resources :ativacao, only: :update, controller: "ativacoes"
    resources :atualizacoes_status, only: [:edit, :update]
    resources :historicos, only: :show
  end
end
