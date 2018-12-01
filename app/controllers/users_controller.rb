class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :edit, :update]
  before_action :correct_user, only: [:edit, :update, :destroy]


  def index
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]) if logged_in?
    random_num = []
    3.times do
      random_num << rand(User.first.id..User.last.id)
    end
    @suggesting_users = User.find(random_num)
  end

  def show
    @user = User.find_by(identifier: params[:identifier])
    @posts = current_user.posts.order(created_at: :desc).page(params[:page]) if logged_in?
    random_num = []
    3.times do
      random_num << rand(User.first.id..User.last.id)
    end
    @suggesting_users = User.find(random_num)
  end

  def edit
    @user = User.find_by(identifier: params[:identifier])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    def user_params
      params.require(:user).permit(:identifier, :email, :name, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find_by(identifier: params[:identifier])
      redirect_to(root_url) unless current_user?(@user)
    end
end
