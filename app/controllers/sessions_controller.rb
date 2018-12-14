class SessionsController < ApplicationController
  before_action :forbid_login_users, only: [:new, :create]
  
  def new
  end

  def create
    @user = User.find_by(identifier: params[:session][:identifier])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      redirect_back_or(root_url)
    else
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private

    def forbid_login_users
      if logged_in?
        redirect_to root_url
      end
    end


end
