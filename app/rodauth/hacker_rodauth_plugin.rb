require "sequel/core"

class HackerRodauthPlugin < RodauthPlugin
  configure do
    # This block is running inside of
    #   plugin :rodauth do
    #     ...
    #   end

    # ==> Features
    # See the Rodauth documentation for the list of available config options:
    # http://rodauth.jeremyevans.net/documentation.html

    # List of authentication features that are loaded.
    enable(
      :omniauth,
      :login,
      :remember,
      :logout,
      :case_insensitive_login,
      :internal_request
    )

    omniauth_provider :google_oauth2,
      ENV["GOOGLE_CLIENT_ID"],
      ENV["GOOGLE_CLIENT_SECRET"], name: :google
    omniauth_provider :github,
      ENV["GITHUB_CLIENT_ID"],
      ENV["GITHUB_CLIENT_SECRET"],
      scope: "user:email",
      name: :github

    # ==> General

    # Prevent rodauth from introspecting the database if we are not using UUIDs
    convert_token_id_to_integer? { Hacker.columns_hash["id"].type == :integer }

    # Change prefix of table and foreign key column names from default "account"
    accounts_table :hackers
    remember_table :hacker_remember_keys

    # The secret key used for hashing public-facing tokens for various features.
    # Defaults to Rails `secret_key_base`, but you can use your own secret key.
    # hmac_secret "<SECRET_KEY>"

    # Use path prefix for all routes.
    prefix "/hacker"

    # Store password hash in a column instead of a separate table.
    account_password_hash_column :password_hash

    # Specify the controller used for view rendering, CSRF, and callbacks.
    rails_controller { Rodauth::HackerController }

    # Specify the model to be used.
    rails_account_model { Hacker }

    # Set password password during create account.
    # verify_account_set_password? false

    # Change some default param keys.
    login_param "email"
    login_label "Email"

    # Redirect back to originally requested location after authentication.
    login_return_to_requested_location? true
    # two_factor_auth_return_to_requested_location? true # if using MFA

    # Autologin the user after they have reset their password.
    # reset_password_autologin? true

    # Delete the account record when the user has closed their account.
    # delete_account_on_close? true

    # Redirect to the app from login and registration pages if already logged in.
    # already_logged_in { redirect login_redirect }

    # Accept both api and form requests
    # Requires the JSON feature
    # only_json? false

    send_email do |email|
      # queue email delivery on the mailer after the transaction commits
      db.after_commit { email.deliver_later }
    end

    # ==> Flash
    # Does not work with only_json?

    # Match flash keys with ones already used in the Rails app.
    # flash_notice_key :success # default is :notice
    # flash_error_key :error # default is :alert

    # Override default flash messages.
    # create_account_notice_flash "Your account has been created. Please verify your account by visiting the confirmation link sent to your email address."
    # require_login_error_flash "Login is required for accessing this page"
    # login_notice_flash nil

    # ==> Validation
    # Override default validation error messages.
    # no_matching_login_message "user with this email address doesn't exist"
    # already_an_account_with_this_login_message "user with this email address already exists"
    # password_too_short_message { "needs to have at least #{password_minimum_length} characters" }
    # login_does_not_meet_requirements_message { "invalid email#{", #{login_requirement_message}" if login_requirement_message}" }

    # ==> Passwords

    # Passwords shorter than 8 characters are considered weak according to OWASP.
    # password_minimum_length 8

    # Custom password complexity requirements (alternative to password_complexity feature).
    # password_meets_requirements? do |password|
    #   super(password) && password_complex_enough?(password)
    # end
    # auth_class_eval do
    #   def password_complex_enough?(password)
    #     return true if password.match?(/\d/) && password.match?(/[^a-zA-Z\d]/)
    #     set_password_requirement_error_message(:password_simple, "requires one number and one special character")
    #     false
    #   end
    # end

    # = bcrypt

    # bcrypt has a maximum input length of 72 bytes, truncating any extra bytes.
    password_maximum_bytes 72 if respond_to?(:password_maximum_bytes)

    # ==> Remember Feature

    # Remember all logged in users.
    after_login { remember_login }

    # Or only remember users that have ticked a "Remember Me" checkbox on login.
    # after_login { remember_login if param_or_nil("remember") }

    # Extend user's remember period when remembered via a cookie
    extend_remember_deadline? true

    # Use separate session key for hacker authentication
    session_key "_hacker_session"

    # Store the user's remember cookie under a namespace
    remember_cookie_key "_hacker_remember"

    # ==> Hooks

    # Validate custom fields in the create account form.
    # before_create_account do
    #   if param("token")
    #     # ensure the token provided does has not been used yet
    #     @invited_hacker = Hackathon::Invitation.find_by(token: param("token"))
    #     if @invited_hacker && @invited_hacker.accepted?
    #       throw_error_status(403, "token", "invalid or exired token")
    #     end
    #   end
    # end

    # Perform additional actions after the account is created.
    # after_create_account do
    #   # Cache the invite token: format -> <email>_<token>
    #   if param("token").present?
    #     Rails.cache.write("#{param("email")}_invite_token", param("token"))
    #   end
    # end

    # Do additional cleanup after the account is closed.
    # after_close_account do
    #   Profile.find_by!(account_id: account_id).destroy
    # end

    # ==> Redirects

    # Ensure auto-login after omniauth account creation
    omniauth_create_account? true

    # Redirect to dashboard after omniauth login/create (user is auto-logged in)
    after_omniauth_create_account do
      # Explicitly login if not already logged in
      login_session(account_id) unless logged_in?
      redirect "/hacker_dashboard"
    end

    # Redirect to home after login.
    login_redirect "/hacker_dashboard"

    # Redirect to home page after logout.
    logout_redirect "/hacker_dashboard"

    # ==> Deadlines
    # Change default deadlines for some actions.
    # verify_account_grace_period 3.days.to_i
    # reset_password_deadline_interval Hash[hours: 6]
    # verify_login_change_deadline_interval Hash[days: 2]
    # remember_deadline_interval Hash[days: 30]
  end
end
