class LikeRelationshipsController < ApplicationController
    before_action :logged_in_user

  def create
    @user = User.find(params[:liked_id])
    current_user.like(@user)
  end

  def destroy
    @user = current_user.like_relationships.find(params[:id]).liked
    current_user.unlike(@user)
  end
end
