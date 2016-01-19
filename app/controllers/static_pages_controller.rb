class StaticPagesController < ApplicationController
  def home
    @micropost = current_user.toukous.build if logged_in?
  end
end
