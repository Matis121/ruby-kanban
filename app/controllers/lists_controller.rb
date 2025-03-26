class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board

  def create
    @list = @board.lists.build(list_params)

    if @list.save
      redirect_to @board, notice: "Lista została utworzona."
    else
      redirect_to @board, alert: "Nie udało się utworzyć listy."
    end
  end

  def update
    @list = @board.lists.find(params[:id])

    if @list.update(list_params)
      redirect_to @board, notice: "Lista zaktualizowana!"
    else
      redirect_to @board, alert: "Nie udało się zaktualizować listy."
    end
  end

  def destroy
    @list = @board.lists.find(params[:id])
    @list.destroy
    redirect_to @board, notice: "Lista usunięta!"
  end

  def update_position
    @list = @board.lists.find(params[:id])
    @list.insert_at(params[:position].to_i + 1)
    head :ok
  end


  private

  def set_board
    @board = Board.find_by(id: params[:board_id])
  end

  def set_list
    @list = @board.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title, :position)
  end
end
