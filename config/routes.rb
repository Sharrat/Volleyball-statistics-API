Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :seasons
      resources :players
      resources :teams
      resources :tournaments
      resources :tournament_stages
      resources :users
      resources :stage_teams
      resources :stage_rounds
      resources :tournament_teams
      resources :matches
      resources :match_sets
      resources :team_stats
    end
  end
end
