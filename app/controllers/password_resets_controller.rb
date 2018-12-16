class PasswordResetsController < ApplicationController
  before_action :set_search, only: [:new, :create, :edit, :update]

  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset])
    if @user
      @user.create_reset_token
      UserMailer.password_reset(@user).deliver_now
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find_by(email: params[:email])
  end

  def update
    @user = User.find_by(email: params[:email])
    if @user.password_reset_expired?
      redirect_to new_password_reset_url
    end
    if params[:password].blank? || params[:password] != params[:password_confirmation]
      render 'edit'
    else
      @user.password = params[:passwrod]
      @user.password_confirmation = params[:password_confirmation]
      if @user.save
        redirect_to root_url
      else
        render 'edit'
      end
    end

  end

  private

    def set_search
      @q = Post.ransack(params[:q])
    end


end
