class RelationshipsController < ApplicationController

  def create
    @path = Rails.application.routes.recognize_path(request.referer)
    @user = User.find_by(id: params[:following_id])
    current_user.follow(@user)

  end

  def destroy
    @path = Rails.application.routes.recognize_path(request.referer)
    @user = Relationship.find(params[:id]).following
    current_user.unfollow(@user)
  end
end
