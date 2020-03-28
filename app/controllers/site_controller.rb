class SiteController < ApplicationController
  def index
    @title = "Welcome to RailSpace!"
  end

  def about
    @title = "About RailSpace"
  end

  def help
    @title = "RailSpace Help"
  end
end
