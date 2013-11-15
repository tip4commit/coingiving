class Project < ActiveRecord::Base
  def deposit_address user
    user.nil? ? nil : DepositAddress.find_by_project_id_and_sponsor_id(id, user.id)    
  end
end
