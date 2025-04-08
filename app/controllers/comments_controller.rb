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

  def edit
    @comment = @card.comments.find(params[:id])

    unless turbo_frame_request?
      redirect_to edit_board_list_card_path(@board, @list, @card), alert: "Please use the Turbo form to edit the comment."
    end
  end

  def update
    @comment = @card.comments.find(params[:id])

    respond_to do |format|
      if turbo_frame_request?
        if @comment.update(comment_params)
          format.turbo_stream
        else
          format.turbo_stream { render :update, status: :unprocessable_entity }
        end
      end
    end
  end

  def cancel
    @comment = @card.comments.find(params[:id])

    respond_to do |format|
      format.turbo_stream
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
