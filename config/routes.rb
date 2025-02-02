Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  # resources :homepage, only: [:index]
  root "homepage#index"
  get "/about", to: "homepage#about"

  get "/invitations/confirm/:token", to: "invitations#confirm", as: :confirm_invitation
  post "/invitations/confirm/:token/decline", to: "invitations#decline", as: :decline_invitation
  post "/invitations/confirm/:token/accept", to: "invitations#accept", as: :accept_invitation

  mount SolidErrors::Engine, at: "/manage/errors"

  mount MissionControl::Jobs::Engine, at: "/manage/jobs"
end
