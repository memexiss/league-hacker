Rails.application.routes.draw do
  get 'course_holes/controller'
  devise_for :users
  resources :users, except: :create
  root to: "home#index"
  resources :golf_courses
  resources :leagues do
    resources :announcements, controller: "league_announcements"
    resources :events, controller: "league_events"
  end
  resources :league_memberships, only: [:create, :destroy]
  resources :scorecard_entries
  namespace :admin do
    root 'dashboard#index'
    resources :golf_courses do
      collection do
        get 'search'
      end
    end
    resources :golf_course_hole_tee
    resources :golf_course_holes
    resources :golf_course_tee_boxes
    resources :leagues do
      resources :events, controller: 'league_events' do
        resources :rounds, controller: 'league_event_rounds' do 
          resources :scorecards, controller: 'league_event_round_scorecards' 
        end
      end
    end
    resources :league_memberships
    resources :league_event_round_scorecards_entries
    resources :league_event_flights
    resources :league_event_flight_memberships
    resources :league_event_teams
    resources :league_events_team_users
    resources :users
  end

end
