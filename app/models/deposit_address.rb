class DepositAddress < ActiveRecord::Base
  include Concerns::DonationsCache
  
  belongs_to :sponsor
  belongs_to :project
  has_many :deposits
  def update_budget
    amount = Deposit.where(
      "created_at > '#{Time.now-30.days}' and deposit_address_id=?", id).sum(:amount)
    update_attribute :budget, amount
  end

end
