class FavoritesController < ApplicationController

  def create
    @post = Post.find_by(id: params[:post_id])
    current_user.favorite(@post)
  end

  def destroy
    @post = Favorite.find_by(id: params[:id]).post
    current_user.unfavorite(@post)
  end
end
