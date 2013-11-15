class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
      t.references :deposit_address, index: true
      t.integer :amount
      t.string :input_tx
      t.integer :confirmations
      t.string :output_tx

      t.timestamps
    end
  end
end
