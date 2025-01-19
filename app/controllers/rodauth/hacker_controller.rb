module Rodauth
  class HackerController < RodauthController
    # used by Rodauth for rendering views, CSRF protection, and running any
    # registered action callbacks and rescue_from handlers

    private

      def current_account
        rodauth.rails_account
      end

      def rodauth(name = :hacker)
        super
      end
  end
end
