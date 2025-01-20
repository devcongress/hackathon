class ProfileDefinition < ::ResourceDefinition
  input :role, choices: %w[Developer Designer Product\ Manager], required: true

  class NewPage < NewPage
    def render_breadcrumbs
      # show breadcrumbs for admins
      if current_user.class == Admin
        super
      end
    end
  end

  new_page_title "Complete Your Create Profile"
  show_page_title "Profile"

  edit_page_title "Edit Your Profile"
  index_page_title "Team Members"

  sort :role
  sort :team
end
