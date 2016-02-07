class UsersController < ApplicationController
 before_action :correct_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to  @user
    else
      render 'new'
    end
  end
  
  def iine # iine_user   users/:id/iine(.:format)  
   @title = "いいね投稿一覧"
   @user = User.find(params[:id])
   @relationships = @user.iinesita_microposts
 end

  def followings # users/:id/followings
  @title = "フォロー"
   @user = User.find(params[:id])
   #@relationships = @user.follower_relationships.find(params[:id]).followed
   @relationships = @user.following_users
  end
  
  def followers
    @title = "フォロワー"
    @user = User.find(params[:id])
    @relationships = @user.follower_users
    render 'followings'
  end
  
  #def like
    #@title = "いいね"
    #@user = User.find(params[:id])
    #@relationships = @user.following_users
  #end
  
  #def liked
    #@title = "いいね"
    #@user = User.find(params[:id])
    #@relationships = @user.following_users
  #end

  def edit
    if current_user != @user
      redirect_to root_path
    end
  end
    #自分のユーザー(current_user)編集ページ(users/:id/edit)ではない場合TOPページへリダイレクト
  
  def update
     if @user.update(user_params)
         flash[:success] = "Profileを更新しました"
        # Updateに成功した場合はprofileページへリダイレクト
        redirect_to user_path
     else
        # Updateに失敗した場合は編集画面へ戻す
      render 'edit'
     end
  end

  private 
  
   def user_params
       params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :location, :about)
   end
  
   def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) if current_user != @user
   end
   
end
