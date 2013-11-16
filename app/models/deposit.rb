class Deposit < ActiveRecord::Base
  belongs_to :deposit_address
  has_one :project, through: :deposit_address
  has_one :sponsor, through: :deposit_address

  scope :by_project, ->(project) { includes(:deposit_address).where('deposit_addresses.project_id = ?', project.id) }
end
