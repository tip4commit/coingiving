class AddDonationPageUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :donation_page_url, :string
  end
end
