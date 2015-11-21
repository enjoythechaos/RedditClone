class PostsController < ApplicationController
  def new
    @post = Post.new
    @sub_id = params[:sub_id]
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id
    @post.sub_id = params[:sub_id]
    if @post.save
      redirect_to post_url(@post)
    else
      flash.now[:errors] = ["Post could not be created.  Sad face."]
      render :new
    end
  end

  def edit
  end

  def update
  end

  # # Handled in subs#show
  # def index
  # end

  def show
  end

  def destroy
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id, :author_id)
  end
end
