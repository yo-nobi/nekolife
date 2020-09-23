class CatsController < ApplicationController
  before_action :require_user_logged_in, only: [:index_my, :show, :edit]
  before_action :correct_user, only: [:edit]
  def index_my
    @cats = current_user.cats.order(id: :desc).page(params[:page]).per(5)
  end
  
  def index_your
    @cats = Cat.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @cat = Cat.find(params[:id])
  end

  def new
    @cat = current_user.cats.build 
  end

  def create
    @cat = current_user.cats.build(cat_params)
    if @cat.save
      flash[:success] = "ネコ登録しました。"
      redirect_to @cat
      
    else
      flash.now[:danger] = "ネコ登録に失敗しました。"
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      flash[:success] = "ネコ詳細ページが更新されました。"
      redirect_to @cat
    else
      flash.now[:danger] = "ネコ詳細ページが更新に失敗しました。"
      render :edit
    end
  end
  private

  def cat_params
    params.require(:cat).permit(:name, :birthday, :variety, :contents, :image)
  end
  
  def correct_user
    @cat = current_user.cats.find_by(id: params[:id])
    unless @cat
      redirect_to root_url
    end
  end
end

