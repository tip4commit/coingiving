ActiveAdmin.register Project do

  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :url
      f.input :donation_page_url
      f.input :about
      f.input :bitcoin_address
    end
    f.actions
  end

  show do |sposnsor|
    attributes_table do
      row :id
      row :name
      row :url
      row :donation_page_url
      row :about
      row :bitcoin_address
    end
  end

  index do
    selectable_column
    column :id
    column :name
    column :url
    default_actions
  end

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model

  permit_params :name, :about, :url, :bitcoin_address, :donation_page_url
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end
  
end
