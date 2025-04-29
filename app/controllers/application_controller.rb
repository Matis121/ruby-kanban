class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def authorize_board_access!
    unless @board.user == current_user || @board.members.include?(current_user)
      redirect_to boards_path
    end
  end
end
