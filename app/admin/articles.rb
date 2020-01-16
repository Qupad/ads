ActiveAdmin.register Article do
  permit_params :title, :text, :life_cycle, :user_id, :category, :published_at, images: []
  actions :all, except: :new
  actions :all, except: :edit

  batch_action :approve do |ids|
    batch_action_collection.find(ids).each do |article|
      article.update(life_cycle: 'approved') if article.life_cycle == 'new'
    end
    redirect_to collection_path, alert: "The advertise has been approved."
  end

  batch_action :decline do |ids|
    batch_action_collection.find(ids).each do |article|
      article.update(life_cycle: 'declined') if article.life_cycle == 'new'
    end
    redirect_to collection_path, alert: "The advertise has been declined."
  end

  action_item :approve, only: :show do
    @article = Article.find(params[:id])
    link_to 'Approve', approve_admin_article_path, method: :put if @article.life_cycle == 'new' || @article.life_cycle != 'approved'
  end

  action_item :decline, only: :show do
    @article = Article.find(params[:id])
    link_to 'Decline', decline_admin_article_path, method: :put if @article.life_cycle == 'new' || @article.life_cycle != 'declined'
  end

  member_action :approve, method: :put do
    article = Article.find(params[:id])
    article.update(life_cycle: 'approved')
    redirect_to admin_article_path
  end

  member_action :decline, method: :put do
    article = Article.find(params[:id])
    article.update(life_cycle: 'declined')
    redirect_to admin_article_path
  end

  scope :all
  scope("New", default: true) { |scope| scope.where(life_cycle: 'new') }
  scope("Approved") { |scope| scope.where(life_cycle: 'approved') }
  scope("Published") { |scope| scope.where(life_cycle: 'published') }

  
  index do
    selectable_column
    id_column
    column :title
    column :text
    column :life_cycle
    column :user
    column :category
    column :published_at
    actions
  end

  show do |article|

    attributes_table do
      row :title
      row :category
      row :user
      row :published_at
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
