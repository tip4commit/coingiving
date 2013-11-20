class DepositAddress < ActiveRecord::Base
  include Concerns::DonationsCache
  
  belongs_to :sponsor
  belongs_to :project
  has_many :deposits

  validates :bitcoin_address, presence: true, bitcoin_address: true

end
