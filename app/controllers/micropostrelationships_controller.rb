class MicropostrelationshipsController < ApplicationController
   before_action :logged_in_user
   
  def create
    @micropost = Micropost.find(params[:micropost_id])
    current_user.iine(@micropost)
    @micropost.save
    redirect_to request.referrer || root_url
  end

  def destroy
    micropost = Micropost.find(params[:id])
    current_user.uniine(micropost)
    redirect_to request.referrer || root_url
  end
end
