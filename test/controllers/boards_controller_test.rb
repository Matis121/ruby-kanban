require "test_helper"

class BoardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:board1)
    @user = users(:user1)
    sign_in @user
  end

  test "should create board" do
    assert_difference("Board.count") do
      post boards_path, params: { board: { title: "test title" } }
    end

    assert_redirected_to board_url(Board.last)
  end

  test "should show board" do
    get board_url(@board)
    assert_response :success
  end

  test "should get edit" do
    get edit_board_path(@board)
    assert_response :success
  end

  test "should update board" do
    patch board_url(@board), params: { board: { title: "new title" } }
    assert_redirected_to board_url(@board)
  end

  test "should destroy board" do
    assert_difference("Board.count", -1) do
      delete board_url(@board)
    end

    assert_redirected_to boards_url
  end
end
