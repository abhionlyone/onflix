Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      sessions: 'auth/sessions',
  }

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :contents, only: :index do
        collection do
          get :movies
          get :seasons
          get :library
          post :purchase
        end
      end
    end
  end
end
