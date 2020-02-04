class ArticlesController < InheritedResources::Base
  skip_before_action :verify_authenticity_token
  before_action :article_select, only: %i[show destroy edit update send_to_approve]
  before_action :authenticate_user!, except: %i[index show]
  helper_method :sort_column, :sort_direction

  def index
    @articles = Article.where(life_cycle: 'published').includes(:user, :category).search(params[:search]).order(sort_column + ' ' + sort_direction)
    if params.has_key?(:category)
      @category = Category.find_by_name(params[:category])
      @articles = @articles.where(category: @category).paginate(page: params[:page])
    else
      @articles = @articles.paginate(page: params[:page])
    end
  end

  def show; end

  def edit; end

  def new
    @article = Article.new
   end

  def create
    @article = Article.new(article_params)
    # @article.images.attach(params[:images])
    @article.user = current_user

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
    # render plain: params[:article].inspect
  end

  def update
    if @article.life_cycle == 'draft' && @article.user == current_user
      if @article.update(article_params)
        redirect_to @article, notice: 'ur advertise was updated'
      else
        redirect_to articles_path, alert: 'no update for u'
      end
    else
      redirect_to articles_path, alert: 'haha no update for u'
    end
  end

  def destroy
    @article.destroy

    redirect_to articles_path, notice: 'Ur post was deleted'
  end

  def delete_image_attachment
    @image = ActiveStorage::Attachment.find(params[:id])
    @image.purge
    redirect_back(fallback_location: root_path)
  end

  def send_to_approve
    @article.life_cycle = 'new'
    if @article.save
      redirect_to persons_profile_path, notice: 'Ur post was queued'
    else
      redirect_to articles_path, notice: 'ERROR'
    end
  end

  private

  def article_params
    params.require(:article).permit(:title, :text, :category_id, images: [])
  end

  private

  def article_select
    @article = Article.includes(:user, :category).find(params[:id])
  end

  private

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
