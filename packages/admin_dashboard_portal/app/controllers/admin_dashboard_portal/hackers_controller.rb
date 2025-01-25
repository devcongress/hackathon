class AdminDashboardPortal::HackersController < ::HackersController
  include AdminDashboardPortal::Concerns::Controller

  authorize :params, through: :request_params

  private

    def request_params
      params
    end
end
