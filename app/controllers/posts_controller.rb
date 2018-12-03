class PostsController < ApplicationController

  def create
    @post = current_user.posts.create(post_params)
    if @post.save
      redirect_to root_url
    else
      redirect_to root_url
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_url
  end

  private

    def post_params
      params.require(:post).permit(:content)
    end
end
