class HackerDefinition < ::ResourceDefinition
  action :check_in,
    interaction: Hackathon::CheckIns::CheckIn
end
