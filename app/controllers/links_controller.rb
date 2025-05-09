class LinksController < ApplicationController
  before_action :set_link, only: [:show, :edit, :update, :destroy]
  def index
    @links = Link.all
    @link ||= Link.new
  end
  def create
    @link = Link.new(links_params)
    if @link.save
      redirect_to root_path, notice: "Page was successfully created."
    else
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
end