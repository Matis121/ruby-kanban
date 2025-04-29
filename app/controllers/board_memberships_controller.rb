class BoardMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :authorize_admin!, only: [ :create ]
  before_action :authorize_board_access!, only: [ :index, :destroy ]

  def index
    @memberships = @board.board_memberships.includes(:user)
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.nil?
      redirect_to board_memberships_path(@board)
      return
    end

    @membership = @board.board_memberships.new(user: @user, role: params[:role] || "member")

    if @membership.save
      redirect_to board_memberships_path(@board)
    else
      redirect_to board_memberships_path(@board)
    end
  end

  def destroy
    @board = Board.find(params[:board_id])
    @membership = BoardMembership.find(params[:id])
    @membership.destroy

    redirect_to board_memberships_path(@board)
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def authorize_admin!
    unless @board.admin?(current_user) || @board.user == current_user
      redirect_to boards_path
    end
  end
end
