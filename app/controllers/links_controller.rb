class LinksController < ApplicationController
  def index
    @links = Link.all
  end
  def create
    @link = Link.new(links_params)
    if @link.save
      redirect_to root_path, notice: "Page was successfully created."
    else
      render :index, status: :unprocessable_entity
    end
  end
  private
  def links_params
    params.require(:link).permit(:url, :title, :description, :image, :view_count)
  end
end