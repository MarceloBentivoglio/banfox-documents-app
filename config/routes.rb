Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :documents, only: [:index, :show] do
    member do
       get :download
    end
  end
end
