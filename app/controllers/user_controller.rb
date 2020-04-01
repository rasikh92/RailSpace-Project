class UserController < ApplicationController
  def index
    @title = "RailSpace User Hub"
  end

  def register
    @title = "Register"

    if request.post? and params[:user]
      @user = User.new(params[:user])
      if @user.save
        flash[:notice] = "User <b>#{@user.screen_name}</b> created!"
        redirect_to :action => "index"
      end
    end
  end
end
