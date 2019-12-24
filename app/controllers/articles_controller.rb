class ArticlesController < ApplicationController
	skip_before_action :verify_authenticity_token
	before_action :article_select, only: [:show, :destroy, :edit, :update, :send_to_approve]
	before_action :authenticate_user!, except: [:index, :show]


	def index
    if params.has_key?(:category)
      @category = Category.find_by_name(params[:category])
      @articles = Article.where(category: @category)
    else
		  @articles = Article.all
    end
	end

  def show
  end

  def edit
  end

  def new
  	@article = Article.new
	end

	def create
		@article = Article.new(article_params)
		#@article.images.attach(params[:images])
		@article.user = current_user
 
  if @article.save
    redirect_to @article
  else
    render 'new'
  end
  	#render plain: params[:article].inspect
	end

	def update
    if @article.life_cycle == 'draft'
  	  if @article.update(article_params)
  	    redirect_to @article, notice: 'ur article was updated bro'
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
		@article = Article.find(params[:id])
  end
end
