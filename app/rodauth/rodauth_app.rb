class RodauthApp < Rodauth::Rails::App
  # auth configuration
  configure ::HackerRodauthPlugin, :hacker
  configure ::AdminRodauthPlugin, :admin

  route do |r|
    # this block is running inside of a roda route
    # see https://github.com/jeremyevans/roda#usage-

    # auth route configuration
    r.rodauth(:hacker)
    r.rodauth(:admin)

    # plugin route configuration
    rodauth(:hacker).load_memory # autologin remembered hackers
    rodauth(:admin).load_memory # autologin remembered admins

    # ==> Authenticating requests
    # Call `rodauth.require_account` for requests that you want to
    # require authentication for. For example:
    #
    # # authenticate /dashboard/* and /account/* requests
    # if r.path.start_with?("/dashboard") || r.path.start_with?("/account")
    #   rodauth.require_account
    # end
  end
end
