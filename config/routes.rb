Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :seasons
      resources :players
      resources :teams
      resources :tournaments
      resources :tournament_stages
      resources :users
    end
  end
end
