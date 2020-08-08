class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :baria_user, only: [:update]

  def show
    @book = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password: params[:password]
      )
    if @user.save
      flash[:notice] = "Signed in successfully."
      redirect_to users_pash(user.id)
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "successfully updated user!"
    else
      render "edit"
    end
  end

  def following
    @user  = User.find(params[:id])
    @users = @user.followings
    render 'show_follow'
  end

  def followers
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'show_follower'
  end

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

   def baria_user
    unless params[:id].to_i == current_user.id
      redirect_to user_path(current_user)
    end
   end
end