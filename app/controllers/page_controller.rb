class PageController < ApplicationController
  def index
    redirect_to boards_path if user_signed_in?
  end
end
