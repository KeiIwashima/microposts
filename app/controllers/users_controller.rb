class UsersController < ApplicationController
 before_action :logged_in_user, only: [:update]
  
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
  
  def edit
    @user = User.find(params[:id])
    if current_user != @user
      redirect_to root_path
    end
  end
    #自分のユーザー(current_user)編集ページ(users/:id/edit)ではない場合TOPページへリダイレクト
  
  def update
    @user = User.find(params[:id])
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
  end
