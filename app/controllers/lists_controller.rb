require "pp"

class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def create
    @list = @board.lists.build(list_params)

    if @list.save
      redirect_to @board, notice: "List created successfully!"
    else
      redirect_to @board, alert: "Failed to create list."
    end
  end

  def update
    @list = @board.lists.find(params[:id])

    if @list.update(list_params)
      redirect_to @board, notice: "List updated!"
    else
      redirect_to @board, alert: "Update failed."
    end
  end

  def destroy
    @list = @board.lists.find(params[:id])
    @list.destroy
    redirect_to @board, notice: "List deleted!"
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
