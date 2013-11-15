class AddInfoToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :url, :string
    add_column :sponsors, :location, :string
  end
end
