Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  mount_devise_token_auth_for "Admin", at: 'admin_auth', skip: [:registration]
  namespace 'api' do
    namespace 'v1' do
      get 'demo/members_only', to: 'demo#members_only'
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
      resources :team_stats
      devise_scope :admin do
        get 'demo/admins_only', to: 'demo#admins_only'
      end
    end
  end
end
