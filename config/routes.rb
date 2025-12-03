Rails.application.routes.draw do
  devise_for :users
  resources :posts do
    collection do
      get :favorites
    end
  end
  resources :favorites, only: %i[create destroy]
  resource :profile
  root "tops#index"
  
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
