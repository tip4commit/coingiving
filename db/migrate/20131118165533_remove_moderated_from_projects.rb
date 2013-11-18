class RemoveModeratedFromProjects < ActiveRecord::Migration
  def change
    remove_column :projects, :moderated, :boolean
  end
end
