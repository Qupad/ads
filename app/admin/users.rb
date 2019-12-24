ActiveAdmin.register User do
  permit_params :email, :encrypted_password, :user_password, :password, :superadmin_role, :supervisor_role, :user_role

  sidebar 'Articles by this User', :only => :show do
    table_for Article.joins(:user).where(:user_id => user.id) do |t|
      t.column("Title") { |article| article.title }
    end
  end

  index do
    selectable_column
    id_column
    column :email
    column :user_password
    column :password
    column :user_role
    actions
  end

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :superadmin_role, :supervisor_role, :user_role
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :superadmin_role, :supervisor_role, :user_role]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
