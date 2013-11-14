class AddAvatarToSponsors < ActiveRecord::Migration
  def change
    add_column :sponsors, :avatar, :string
  end
end
