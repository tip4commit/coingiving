class Project < ActiveRecord::Base
  def deposit_address user
    user.nil? ? nil : DepositAddress.find_by_project_id_and_sponsor_id(id, user.id)    
  end

  has_many :deposit_addresses
  has_many :deposits, :through => :deposit_addresses
end
