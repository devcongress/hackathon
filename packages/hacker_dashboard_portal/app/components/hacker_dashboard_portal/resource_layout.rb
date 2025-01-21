module HackerDashboardPortal
  class ResourceLayout < ::Plutonium::UI::Layout::ResourceLayout
    def main_attributes = mix(super, {
      class!: "pt-20 p-4 min-h-screen mx-auto w-2/3"
    })
  end
end
