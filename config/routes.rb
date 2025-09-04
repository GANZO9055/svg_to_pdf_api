Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  root "home#index"

  namespace :api do
    namespace :v1 do
      resources :pdfs, only: [:create, :show]
    end
  end
end
