class DepositAddress < ActiveRecord::Base
  belongs_to :sponsor
  belongs_to :project
  has_many :deposits
  def update_budget
    amount = Deposit.where("created_at > '#{Time.now-30.days}' and deposit_address_id=?",1).sum(:amount)
    update_attribute :budget, amount
  end
end
