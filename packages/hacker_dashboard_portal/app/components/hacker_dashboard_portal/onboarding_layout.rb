module HackerDashboardPortal
  class OnboardingLayout < ::Plutonium::UI::Layout::ResourceLayout
    include Phlex::Rails::Helpers::LinkTo
    include Phlex::Rails::Helpers::ImageTag

    private

    def main_attributes = mix(super, {
      class!: ""
    })

    def render_before_main
      div(class: "flex justify-center pt-8 pb-4") do
        link_to main_app.root_path, class: "group" do
          image_tag "icon_256.png",
            class: "w-16 h-16 transition-transform group-hover:scale-105"
        end
      end
    end
  end
end
