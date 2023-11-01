class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
      # 保存成功の処理
    else
      # 保存失敗の処理
      flash.now[:error] = @user.errors.full_messages  # エラーメッセージをフラッシュに設定する例
      render :new
    end
  end

  def index
    @user = current_user
    @new_book = Book.new
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    unless @user.id == current_user.id
      redirect_to user_path(current_user.id)
    end
    redirect_to user_path(@user.id)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user = User.find(params[:id])
    unless user.id == current_user.id
      redirect_to post_images_path
    end
  end
end
