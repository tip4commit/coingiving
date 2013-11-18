class DropBudgetFromDepositAddress < ActiveRecord::Migration
  def change
    remove_column :deposit_addresses, :budget
  end
end
