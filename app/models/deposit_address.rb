class DepositAddress < ActiveRecord::Base
  include Concerns::DonationsCache
  
  belongs_to :sponsor
  belongs_to :project
  has_many :deposits

end
