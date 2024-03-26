# frozen_string_literal: true

class InitialSetup < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""

      ## Recoverable
      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      ## Rememberable
      t.datetime :remember_created_at

      ## Trackable
      # t.integer  :sign_in_count, default: 0, null: false
      # t.datetime :current_sign_in_at
      # t.datetime :last_sign_in_at
      # t.string   :current_sign_in_ip
      # t.string   :last_sign_in_ip

      ## Confirmable
      # t.string   :confirmation_token
      # t.datetime :confirmed_at
      # t.datetime :confirmation_sent_at
      # t.string   :unconfirmed_email # Only if using reconfirmable

      ## Lockable
      # t.integer  :failed_attempts, default: 0, null: false # Only if lock strategy is :failed_attempts
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at

      t.string :first_name 
      t.string :last_name  
      t.string :phone 
      t.integer :role, default: 0
      t.string :ghin_number 
      t.decimal :ghin_handicap 
      
      t.timestamps null: false
    end
    
    add_index :users, :email,                unique: true
    add_index :users, :reset_password_token, unique: true
    add_index :users, :ghin_number, unique: true
    # add_index :users, :confirmation_token,   unique: true
    # add_index :users, :unlock_token,         unique: true

    create_table :golf_courses do |t|
      t.string :name
      t.integer :remote_api_version 
      t.string :remote_api_id 
      t.string :address 
      t.string :city 
      t.decimal :latitude 
      t.decimal :longitude 
      t.string :country 
      t.string :fairway_grass 
      t.string :green_grass 
      t.integer :number_of_holes 
      t.string :length_format 
      t.string :phone 
      t.string :state 
      t.string :website 
      t.string :zip 

      t.timestamps
    end

    create_table :golf_course_tee_boxes do |t|
      t.string :tee
      t.integer :slope
      t.decimal :handicap
      t.references :golf_course

      t.timestamps
    end

    create_table :golf_course_holes do |t|
      t.bigint :golf_course_id
      t.integer :hole
      t.integer :par
      t.integer :handicap


      t.timestamps
    end
    add_index :golf_course_holes, [:golf_course_id, :hole], unique: true  

    create_table :golf_course_hole_tees do |t|
      t.string :name
      t.string :color
      t.integer :yards
      t.references :golf_course_hole

      t.timestamps
    end
    
    create_table :leagues do |t|
      t.string :name
      t.string :payment_link
      t.integer :league_type

      t.timestamps
    end

    create_table :league_events do |t|
      t.integer :event_type
      t.date :start_date
      t.date :end_date
      t.decimal :entry_fee
      t.integer :number_of_rounds
      t.decimal :per_round_fee
      t.integer :average_holes_per_round
      t.integer :status, default: 0
      t.references :league


      t.timestamps
    end

    create_table :league_event_rounds do |t|
      t.integer :position
      t.integer :scoring_format
      t.integer :playing_format
      t.date :start_date
      t.date :end_date
      t.integer :starting_hole
      t.integer :number_of_holes
      t.references :event

      t.timestamps
    end

    create_table :league_event_flights do |t|
      t.string :name
      t.references :event

      t.timestamps
    end

    create_table :league_event_teams do |t|
      t.references :event
      t.string :name
      t.integer :handicap_format, default: 0 
      t.integer :handicap

      t.timestamps
    end

    create_table :league_memberships do |t|
      t.integer :membership_type
      t.references :league
      t.references :user

      t.timestamps
    end

    create_table :league_event_round_scorecards do |t|
      t.references :round
      t.references :user
      t.decimal :score_gross
      t.decimal :score_net
      t.decimal :score_best_of_holes
      t.decimal :score_chicago
      t.decimal :score_stableford
      t.integer :computed_score_method

      t.timestamps
    end

    create_table :league_event_flight_memberships do |t|
      t.references :flight
      t.references :user
      
      t.timestamps
    end

    create_table :league_event_round_scorecard_entries do |t|
      t.integer :score
      t.datetime :submitted_at
      t.references :scorecard
      t.references :hole
      
      t.timestamps
    end

    create_table :league_event_team_team_users do |t|
      t.references :user
      t.references :team

      t.timestamps
    end

    create_table :league_announcements do |t|
      t.references :league
      t.string :title
      t.text :body
      t.datetime :published_at
      t.datetime :unpublished_at
      t.integer :status

      t.timestamps
    end

    create_table :league_announcement_reads do |t|
      t.references :league_announcement, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.datetime :read_at
      
      t.timestamps
  end

end
