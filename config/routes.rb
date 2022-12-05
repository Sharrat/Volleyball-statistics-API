Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :seasons
      resources :teams
    end
  end
end
