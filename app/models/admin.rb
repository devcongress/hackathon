# == Schema Information
#
# Table name: admins
#
#  id            :integer          not null, primary key
#  email         :string           not null
#  password_hash :string
#  status        :integer          default("unverified"), not null
#
# Indexes
#
#  index_admins_on_email  (email) UNIQUE WHERE status IN (1, 2)
#
class Admin < ResourceRecord
  include Rodauth::Rails.model(:admin)
  validates :email, presence: true

  enum :status, unverified: 1, verified: 2, closed: 3
  # scope :associated_with_admin, -> (admin) { }
end
