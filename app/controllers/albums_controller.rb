class AlbumsController < ApplicationController

  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @my_albums = Album.where(owner_id: current_user)
  end

  def new
    @album = Album.new
  end

  def create
    raise params.inspect
    @album = Album.new(album_params, owner: current_user)
    @album.build_contributors(contributor_params)
    if @album.save
      redirect_to @album
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    @album.destroy
    redirect_to root_path
  end

  private
    def set_album
      @album = Album.find(params[:id])
    end

    def album_params
      params.require(:album).permit(:title)
    end

    def contributor_params
      params.require(:contributor).permit(:names => [])
    end
end