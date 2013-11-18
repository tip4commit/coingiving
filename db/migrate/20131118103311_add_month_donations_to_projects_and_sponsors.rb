class AddMonthDonationsToProjectsAndSponsors < ActiveRecord::Migration
  def change
    add_column :projects, :month_donations, :integer, :limit => 8
    add_column :sponsors, :month_donations, :integer, :limit => 8
    add_column :deposit_addresses, :month_donations, :integer, :limit => 8
  end
end
