require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @board = boards(:board1)
    @list = lists(:list1)
    @card = cards(:card1)
    @comment = comments(:comment1)
    @user = users(:user1)
    sign_in @user
  end

  test "should create comment" do
    assert_difference("Comment.count") do
      post board_list_card_comments_path(@board, @list, @card),
        params: {
          comment: {
            content: "New test comment"
          }
        },
        headers: { "Accept" => "text/vnd.turbo-stream.html" }
    end

    assert_response :success  # turbo_stream defaults to 200 OK
  end

  test "should destroy comment" do
    assert_difference("Comment.count", -1) do
      delete board_list_card_comment_path(@board, @list, @card, @comment)
    end
    assert_redirected_to board_list_card_path(@board, @list, @card)
  end

  test "should update comment" do
    patch board_list_card_comment_path(@board, @list, @card, @comment),
      params: { comment: { content: "new comment content" } },
      headers: { "Accept" => "text/vnd.turbo-stream.html" }

    assert_response :success
    @comment.reload
    assert_equal "new comment content", @comment.content
  end
end
