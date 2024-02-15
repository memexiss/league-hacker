Rails.application.routes.draw do
  get 'course_holes/controller'
  devise_for :users
  resources :users, except: :create
  root to: "home#index"
  resources :golf_courses
  resources :leagues
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
    resources :leagues
    resources :league_announcements
    resources :league_memberships
    resources :league_events 
    resources :league_event_rounds
    resources :league_event_round_scorecards
    resources :league_event_round_scorecards_entries
    resources :league_event_flights
    resources :league_event_flight_memberships
    resources :league_event_teams
    resources :league_events_team_users
    resources :users
  end

end
