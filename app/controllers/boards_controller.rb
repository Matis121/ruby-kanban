class BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_board, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_board_access!, only: [ :show ]
  before_action :authorize_board_owner!, only: [ :edit, :update, :destroy ]

  # GET /boards or /boards.json
  def index
    @boards = current_user.accessible_boards
  end

  # GET /boards/1 or /boards/1.json
  def show
    @board = Board.find(params[:id])
    @lists = @board.lists.order(:position)

    @list_count = @board.lists.count
  end


  # GET /boards/1/edit
  def edit
  end

  # POST /boards or /boards.json
  def create
    @board = current_user.boards.build(board_params)

    respond_to do |format|
      if @board.save
        format.html { redirect_to @board, notice: "Tablica została utworzona." }
        format.json { render :show, status: :created, location: @board }
      else
        format.turbo_stream { render partial: "boards/form", formats: [ :html ], locals: { board: @board }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /boards/1 or /boards/1.json
  def update
    respond_to do |format|
      if @board.update(board_params)
        format.html { redirect_to @board, notice: "Tablica została zaktualizowana." }
        format.json { render :show, status: :ok, location: @board }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @board.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /boards/1 or /boards/1.json
  def destroy
    @board.destroy!

    respond_to do |format|
      format.html { redirect_to boards_path, status: :see_other, notice: "Tablica została usunięta." }
      format.json { head :no_content }
    end
  end

  private
    def set_board
      @board = Board.find(params[:id])
    end

    def board_params
      params.require(:board).permit(:title)
    end

    def authorize_board_access!
      unless @board.user == current_user || @board.members.include?(current_user)
        redirect_to boards_path
      end
    end

    def authorize_board_owner!
      unless @board.user == current_user
        redirect_to boards_path
      end
    end
end
