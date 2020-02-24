class PersonsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def profile
    @articles = current_user.articles.order(sort_column + ' ' + sort_direction).paginate(page: params[:page])
  end

  private

  def sort_column
    Article.column_names.include?(params[:sort]) ? params[:sort] : 'title'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end
end
