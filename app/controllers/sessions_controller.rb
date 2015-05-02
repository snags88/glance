class SessionsController < ApplicationController

  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
  end

  def create
    @user = User.find_or_create_from_auth_hash(auth_hash)
    login(@user)
    redirect_to root_path
  end

  def destroy
    logout
    redirect_to root_path
  end

  private
    def auth_hash
      request.env['omniauth.auth']
    end
end
