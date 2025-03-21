class CardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [ :create ]
  before_action :set_list, only: [ :create ]
  before_action :set_card, only: [ :update ]

  def create
    @card = @list.cards.build(card_params)

    if @card.save
      redirect_to @board, notice: "Karta została dodana!"
    else
      redirect_to @board, alert: "Nie udało się dodać karty."
    end
  end


  def edit
    @card = Card.find(params[:id])
  end


  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Board was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @card = Card.find(params[:id]).destroy!

    respond_to do |format|
      format.html { redirect_to boards_path, status: :see_other, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private

  def set_board
    @board = Board.find(params[:board_id])
  end

  def set_list
    @list = @board.lists.find(params[:list_id])
  end

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:title, :description)
  end
end
