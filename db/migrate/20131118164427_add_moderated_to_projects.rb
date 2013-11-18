class AddModeratedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :moderated, :boolean, default: false
  end
end
