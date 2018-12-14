class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :following, :followers, :favorites]
  before_action :suggesting_users, only: [:index, :show, :following, :followers, :favorites, :search]
  before_action :logged_in_user, except: [:new]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :forbid_login_users, only: [:new, :create]
  before_action :set_search, only: [:index, :show, :edit, :following, :followers, :favorites, :search]


  def index
    @post = current_user.posts.build if logged_in?
    @feed_items = current_user.feed.order(created_at: :desc).page(params[:page]) if logged_in?
    unless logged_in?
      redirect_to login_url
    end
  end

  def show
    @posts = @user.posts.order(created_at: :desc).page(params[:page])
  end

  def edit

  end

  def update
    @user = User.find_by(identifier: params[:identifier])
    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
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
    redirect_to login_url
  end

  def following
    @users = @user.following.page(params[:page])
    render 'show_follow'
  end

  def followers
    @users = @user.followers.page(params[:page])
    render 'show_follow'
  end

  def favorites
    @posts = @user.fav_posts.page(params[:page])
    render 'show_favorites'
  end

  def search
    @q = Post.ransack(params[:q])
    @search_posts = @q.result(distinct: true).page(params[:page])
  end

  private

    def set_user
      @user = User.find_by(identifier: params[:identifier])
    end

    def set_search
      @q = Post.ransack(params[:q])
    end

    def user_params
      params.require(:user).permit(:identifier, :email, :name, :password, :password_confirmation, :image)
    end

    def logged_in_user
      unless logged_in?
        store_location
        redirect_to login_url
      end
    end

    def forbid_login_users
      if logged_in?
        redirect_to root_url
      end
    end

    def correct_user
      @user = User.find_by(identifier: params[:identifier])
      redirect_to(root_url) unless current_user?(@user)
    end

    def suggesting_users
      random_num = []
      3.times do
        random_num << rand(User.first.id..User.last.id)
      end
      @suggesting_users = User.find(random_num)
    end
end
