Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace 'api' do
    namespace 'v1' do
      resources :seasons
      resources :players
      resources :teams
      resources :tournaments
      resources :tournament_stages
      resources :stage_teams
      resources :stage_rounds
      resources :tournament_teams
      resources :matches
      resources :match_sets
    end
  end
end
