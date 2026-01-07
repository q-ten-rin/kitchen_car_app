Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :posts, param: :uuid do
    collection do
      get :favorites
      get :autocomplete
    end
    resources :comments, only: [:create, :destroy, :edit, :update]
  end
  resources :favorites, only: %i[create destroy]
  resource :profile
  root "tops#index"
  
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  get "terms", to: "static_pages#terms"
  get "privacy", to: "static_pages#privacy"
  get "contact", to: "static_pages#contact"

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
