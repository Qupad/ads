class PersonsController < ApplicationController
  def profile
    @articles = Article.where(user: current_user).includes(:user, :category)
  end
end
