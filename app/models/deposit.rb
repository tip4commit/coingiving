class Deposit < ActiveRecord::Base
  belongs_to :deposit_address

  delegate :project, :to => :deposit_address
  delegate :sponsor, :to => :deposit_address
  
  scope :by_project, ->(project) { includes(:deposit_address).where('deposit_addresses.project_id = ?', project.id) }
end
