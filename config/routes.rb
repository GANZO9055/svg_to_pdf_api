Rails.application.routes.draw do

  root "home#index"

  if Rails.env.development? || Rails.env.test?
    mount Rswag::Ui::Engine => '/api-docs'
    mount Rswag::Api::Engine => '/api-docs'
  end

  namespace :api do
    namespace :v1 do
      resources :pdfs, only: [:create, :show]
    end
  end
end
