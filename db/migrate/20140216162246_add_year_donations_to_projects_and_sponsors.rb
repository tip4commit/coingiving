class AddYearDonationsToProjectsAndSponsors < ActiveRecord::Migration
  def change
    add_column :projects, :year_donations, :integer, :limit => 8
    add_column :sponsors, :year_donations, :integer, :limit => 8
    add_column :deposit_addresses, :year_donations, :integer, :limit => 8
  end
end
