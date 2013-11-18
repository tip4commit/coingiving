ActiveAdmin.register Sponsor do

  actions :index, :show, :update, :edit, :destroy

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :url
      f.input :location
    end
    f.actions
  end

  show do |sposnsor|
    attributes_table do
      row :id
      row :name
      row :email
      row :url
      row :location
      row :avatar do
        gravatar_image_tag sposnsor.email, gravatar: {size: 200}
      end
    end
  end

  index do
    selectable_column
    column :id
    column :avatar do |sposnsor|
      gravatar_image_tag sposnsor.email, gravatar: {size: 20}
    end
    column :name
    column :email
    default_actions
  end
  
  permit_params :name, :email, :url, :location
  
end
