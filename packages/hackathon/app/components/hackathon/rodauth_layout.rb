module Hackathon
  class RodauthLayout < ::Plutonium::UI::Layout::RodauthLayout
    def render_logo
      link_to root_path, class: "flex items-center my-4" do
        helpers.inline_svg_tag(helpers.resource_logo_asset, class: "h-24 dark:text-white")
      end
    end
  end
end
