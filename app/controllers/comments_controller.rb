class CommentsController < ApplicationController
  before_action :set_card

  def create
    @comment = @card.comments.build(comment_params)
    @comment.user = current_user if defined?(current_user)

    if @comment.save
      respond_to do |format|
        format.turbo_stream { render :create, locals: { board: @board, list: @list, card: @card, comment: @comment } }
        format.json { render :show, status: :created, location: @comment }
      end
    else
      respond_to do |format|
        format.turbo_stream { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment = @card.comments.find(params[:id])
    @comment.destroy

    if @comment.user == current_user
      respond_to do |format|
        format.html { redirect_to board_list_card_path(@board, @list, @card), notice: "Komentarz usunięty." }
        format.turbo_stream { render :destroy, locals: { board: @board, list: @list, card: @card, comment: @comment } }
        format.json { head :no_content }
      end
    end
  end

  private

  def set_card
    @board = Board.find(params[:board_id])
    @list = @board.lists.find(params[:list_id])
    @card = @list.cards.find(params[:card_id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
