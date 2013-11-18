class AddModeratedAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :moderated_at, :timestamp
  end
end
