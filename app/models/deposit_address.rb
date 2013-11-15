class DepositAddress < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :project
  has_many :deposits
end
