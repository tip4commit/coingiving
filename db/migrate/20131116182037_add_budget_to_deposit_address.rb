class AddBudgetToDepositAddress < ActiveRecord::Migration
  def change
    add_column :deposit_addresses, :budget, :integer, :limit => 8
  end
end
