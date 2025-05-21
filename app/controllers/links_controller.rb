class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  before_action :check_if_editable, only: [:edit, :update, :destroy]
  def index
    @links = Link.all
    @link ||= Link.new
  end
  def create
    @link = Link.new(links_params)
    @link.user = current_user
    if @link.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Page was successfully created." }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("links", @link) }
      end
    else
      index
      render :index, status: :unprocessable_entity
    end
  end
  def edit
  end
  def show
  end
  def update
    if @link.update links_params
      redirect_to @link
    else
      format.html { render :edit }
      format.json { render json: @link.errors, status: :unprocessable_entity }
    end
  end
  def destroy
    @link.destroy
    redirect_to links_path
  end
  private
  def links_params
    params.require(:link).permit(:url, :title, :description, :image, :view_count)
  end
  def check_if_editable
    unless @link.editable_by?(current_user)
      redirect_to @link, alert: 'You cant do that'
    end
  end
end