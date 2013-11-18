class Project < ActiveRecord::Base
  include Concerns::DonationsCache
  
  has_many :deposit_addresses
  has_many :deposits, :through => :deposit_addresses
  has_many :sponsors, -> { where('deposit_addresses.month_donations > 0') }, :through => :deposit_addresses

  validates :url, uniqueness: true, url: true
  validates :donation_page_url, uniqueness: true, url: true

  scope :moderated, -> { where("moderated_at is not ?", nil) }

  def deposit_address user
    user.nil? ? nil : DepositAddress.find_by_project_id_and_sponsor_id(id, user.id)    
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end

end
