class CommentsController < ApplicationController

  def create
    @micropost = Micropost.find(params[:comment][:micropost_id])
    @comment = @micropost.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = '回答しました。'
      redirect_to @micropost
    else
      @comments = @micropost.comments.order(id: :desc).page(params[:page]).per(5)
      flash.now[:danger] = '回答出来ませんでした。'
      render 'microposts/show'
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])
    @comment.destroy
    flash[:success] = '回答が削除されました'
    redirect_to root_url
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:content, :user_id, :micropost_id)
  end
end
