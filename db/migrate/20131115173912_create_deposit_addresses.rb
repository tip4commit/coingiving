class CreateDepositAddresses < ActiveRecord::Migration
  def change
    create_table :deposit_addresses do |t|
      t.references :sponsor, index: true
      t.references :project, index: true
      t.string :bitcoin_address

      t.timestamps
    end
  end
end
