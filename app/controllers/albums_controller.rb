class AlbumsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]
  before_action :shared_album, only: [:show]

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
  end

  def update
    @album.update_album(album_params)
    @album.update_contributors(contributor_params[:names])
    # TODO: add ability to update order of photos
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

    def shared_album
      authenticate_user! if (params[:p] != @album.token) || !(@album.public)
    end
end
