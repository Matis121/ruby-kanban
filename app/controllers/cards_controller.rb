class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board
  before_action :set_list
  before_action :set_card, only: [ :edit, :update, :destroy, :update_position ]
  before_action :authorize_board_access!

  def create
    @card = @list.cards.build(card_params)

    if @card.save
      redirect_to board_path(@board), notice: "Karta została dodana!"
    else
      redirect_to board_path(@board), status: :unprocessable_entity
    end
  end

  def edit
    unless turbo_frame_request?
      redirect_to board_path(@board)
    end
  end

  def update
    if @card.update(card_params)
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @card.destroy
      redirect_to board_path(@board), status: :see_other, notice: "Karta została usunięta!"
    else
      redirect_to board_path(@board), alert: "Nie udało się usunąć karty."
    end
  end

  def update_position
    @card.update(list_id: params[:new_list_id], position: params[:position].to_i + 1)
    head :ok
  end

  private

  def set_board
    @board = Board.find(params[:board_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to boards_path, alert: "Nie znalezieno tablicy."
  end

  def set_list
    @list = @board.lists.find(params[:list_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to board_path(@board), alert: "Nie znaleziono listy."
  end

  def set_card
    @card = @list.cards.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to board_list_path(@board, @list), alert: "Nie znalezino karty."
  end

  def card_params
    params.require(:card).permit(:title, :description)
  end
end
