require "test_helper"

class CardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:board1)
    @list = lists(:list1)
    @card = cards(:card1)
    @user = users(:user1)
    sign_in @user
  end

  test "should create card" do
    assert_difference("Card.count") do
      post board_list_cards_path(@board, @list), params: {
        card: {
          title: "New test card",
          description: "Card description"
        }
      }
    end

    assert_redirected_to board_path(@list.board)
  end

  test "should destroy card" do
    assert_difference("Card.count", -1) do
      delete board_list_card_path(@board, @list, @card)
    end

    assert_redirected_to board_path(@card.list.board)
  end

  test "should not create card with invalid params" do
    assert_no_difference("Card.count") do
      post board_list_cards_path(@board, @list), params: {
        card: {
          title: ""
        }
      }
    end

    assert_response :unprocessable_entity
  end
end
