class ChangeAmountInDeposits < ActiveRecord::Migration
  def change
    change_column :deposits, :amount, :integer, :limit => 8
  end
end
