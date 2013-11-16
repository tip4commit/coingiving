class Project < ActiveRecord::Base
  
  has_many :deposit_addresses
  has_many :deposits, :through => :deposit_addresses

  validates :url, uniqueness: true, url: true
  validates :donation_page_url, uniqueness: true, url: true

  def deposit_address user
    user.nil? ? nil : DepositAddress.find_by_project_id_and_sponsor_id(id, user.id)    
  end

end
