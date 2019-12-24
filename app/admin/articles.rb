ActiveAdmin.register Article do
  permit_params :title, :text, :life_cycle, :user_id, :category, images: []
  
    scope("Draft") { |scope| scope.where(life_cycle: 'draft') }
  
  index do
    selectable_column
    id_column
    column :title
    column :text
    column :life_cycle
    column :user_id
    column :category
    actions
  end

  show do |article|
    attributes_table do
      row :title
      row :category
      row :user
      row :life_cycle
      row :text

      row "Images" do
        ul do
          article.images.each do |i|
            li do
              image_tag(i, style: 'width:50%')
            end
          end
        end
      end
    end
    active_admin_comments
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :text, :life_cycle, :kind, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :text, :life_cycle, :kind, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
