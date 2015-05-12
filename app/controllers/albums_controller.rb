class AlbumsController < ApplicationController

  before_action :set_album, only: [:show, :edit, :update, :destroy]

  def index
    @albums = current_user.albums
    @contributions = current_user.contributions
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.build_with_owner(album_params, current_user)
    @album.build_contributors(contributor_params[:names])
    @album.save ? (redirect_to @album) : (render 'new')
  end

  def show
    @album.build_photos
  end

  def edit
    #TODO allow add/remove of photos
  end

  def update
    @album.update_album(album_params)
    @album.update_contributors(contributor_params[:names])
    @album.save ? (redirect_to @album) : (render 'edit')
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
      params.require(:album).permit(:title, :public)
    end

    def contributor_params
      params.require(:contributor).permit(:names => [])
    end
end
