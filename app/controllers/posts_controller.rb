class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = Post.where(author: @user)
  end

  def show
    puts params
    @post = Post.find(params[:id])
  end

  # form actions
  def new
    @user = User.find(current_user.id)
    @post = @user.post.new
    render :new, locals: { post: @post }
  end

  def create
    @user = User.find(params[:user_id])
    @post = @user.post.new(post_params)
    respond_to do |format|
      format.html do
        if @post.save
          flash[:success] = 'Post created successfully'
          redirect_to "#{user_posts_path(@user)}/#{@post.id}"
        else
          flash[:error] = 'Post not created'
          render :new, locals: { post: @post }
        end
      end
    end
  end

  private

  def post_params
    params.require(:new_post).permit(:title, :text)
  end
end
