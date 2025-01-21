module HackerDashboardPortal
  class ResourceLayout < ::Plutonium::UI::Layout::ResourceLayout
    def main_attributes = mix(super, {
      class!: "pt-20 p-6 min-h-screen mx-auto md:w-2/3"
    })
  end
end
