class ChangeSponsor < ActiveRecord::Migration
  def change
    change_column :sponsors, :private_donations, :boolean, :default => false
  end
end
