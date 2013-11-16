class AddPrivateDonationsToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :private_donations, :boolean
  end
end
