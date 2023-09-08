class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @followings = @user.followings
    @followers = @user.followers
    @books = @user.books
    @book = Book.new
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "edit"
    end
  end


  # フォロー一覧
  def follows
    user = User.find(params[:id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
