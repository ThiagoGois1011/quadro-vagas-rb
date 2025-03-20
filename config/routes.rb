Rails.application.routes.draw do
  resource :session
  resources :passwords, param: :token
  resource :registration, only: %i[ new create ]

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "home#index"

  resources :users, only: [ :index ] do
    member do
      patch :toggle_status
    end
  end

  resources :job_postings, only: %i[ index show new create edit update] do
    resources :tags, only: %i[ new create ]
  end
  resources :company_profiles, only: [ :show, :new, :create ]
  resources :experience_levels, only: [ :index, :new, :create, :edit, :update ] do
    post :active, on: :member
    post :archive, on: :member
  end

  get "search", to: "home#search", as: :search_jobs, param: :query
end
