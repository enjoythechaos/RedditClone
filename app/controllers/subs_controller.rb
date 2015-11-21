class SubsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :destroy]
  before_action :require_moderator, only: [:edit]

  def new
    @sub = Sub.new
  end

  def create
    # @sub = Sub.new(sub_params)
    # @sub.user_id = current_user.id
    @sub = current_user.subs.new(sub_params)

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash[:errors] = ["Sub could not be created :( \n(you suck!)"]
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    unless @sub
      flash[:errors] = ["Sub does not exist dummy"]
      redirect_to subs_url
    end
  end

  def update
    @sub = Sub.find(params[:id])
    # @sub.description = sub_params[:description]
    # @sub.title = sub_params[:title]
    # @sub.save!
    if @sub.update(sub_params)
      flash[:notices] = ['Updates saved!']
      redirect_to sub_url(@sub)
    else
      #other stuff
    end
  end

  def destroy
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def index
    @subs = Sub.all.order('title')
  end

  private
  def sub_params
    params.require(:sub).permit(:title, :description)
  end

end
