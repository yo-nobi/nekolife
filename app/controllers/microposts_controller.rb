class MicropostsController < ApplicationController
  
  def index_food
    @food = Micropost.new
    @foods = Micropost.where(category: "食事").order(id: :desc).page(params[:page]).per(5)
  end
  
  def index_live
    @live = Micropost.new
    @lives = Micropost.where(category: "棲み家").order(id: :desc).page(params[:page]).per(5)
  end
  
  def index_play
    @play = Micropost.new
    @plays = Micropost.where(category: "遊び").order(id: :desc).page(params[:page]).per(5)
  end
  
  def show
    @micropost = Micropost.find(params[:id])
    @comment = @micropost.comments.build
    @comments = @micropost.comments.order(id: :desc).page(params[:page]).per(5)
    
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = '質問を投稿しました。'
      if (@micropost.category == "食事")
        @foods = Micropost.where(category: "食事").order(id: :desc).page(params[:page]).per(5)
        redirect_to food_url
      elsif (@micropost.category == "棲み家")
        @lives = Micropost.where(category: "棲み家").order(id: :desc).page(params[:page]).per(5)
        redirect_to live_url
      else (@micropost.category == "遊び")
        @plays = Micropost.where(category: "遊び").order(id: :desc).page(params[:page]).per(5)
        redirect_to play_url
      end
    else
      @microposts = Micropost.order(id: :desc).page(params[:page])
      flash.now[:danger] = '質問の投稿に失敗しました。'
      if (@micropost.category == "食事")
        @food = @micropost
        @foods = Micropost.where(category: "食事").order(id: :desc).page(params[:page]).per(5)
        render "index_food"
      elsif (@micropost.category == "棲み家")
        @live = @micropost
        @lives = Micropost.where(category: "棲み家").order(id: :desc).page(params[:page]).per(5)
        render "index_live"
      else (@micropost.category == "遊び")
        @play = @micropost
        @plays = Micropost.where(category: "遊び").order(id: :desc).page(params[:page]).per(5)
        render "index_play"
      end
        
    end
  end

  def destroy  
    @micropost = current_user.microposts.find_by(id: params[:id])
    @micropost.destroy
    flash[:success] = '質問が削除されました'
    redirect_to root_url
  end
  
  private
  
  def micropost_params
    params.require(:micropost).permit(:category, :contents, :comments, :user_id)
  end
end
