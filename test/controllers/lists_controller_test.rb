require "test_helper"

class ListsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:board1)
    @list = lists(:list1)
    @user = users(:user1)
    sign_in @user
  end

  test "should create list" do
    assert_difference("List.count") do
      post board_lists_path(@board), params: {
        list: {
          title: "New test list"
        }
      }
    end
    assert_redirected_to board_path(@list.board)
  end

  test "should destory list" do
    assert_difference("List.count", -1) do
      delete board_list_path(@board, @list)
    end
    assert_redirected_to board_path(@list.board)
  end
end
