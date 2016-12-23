class CommentCreator
  # Public: Create comments for Delivery and OrderItem
  #
  #   comment_params - Hash of comments parameter
  #     :order_item  - Hash of order_item comment, follow format ({id: content})
  #     :delivery    - Hash of deliverycomment, follow format ({id: content})
  #   user_id        - The Integer representation of User Id, who create comments
  #
  # Examples
  #
  #   user = User.create(email: "test@gmail.com", password: "abcdefdfd")
  #   args = { delivery: { 1 => "this is" }, order_item: { 5 => "a comment" } }
  #   CommentCreator.new.create(args, user.id)
  def create(comment_params, user_id)
    return unless comment_params

    if comment_params.fetch(:order_item, nil)
      comment_params[:order_item].each do |k,v|
        if v && v.present?
          Comment.create(user_id: user_id, commentable_type: "OrderItem", commentable_id: k, content: v)
        end
      end
    end

    if comment_params.fetch(:delivery, nil)
      comment_params[:delivery].each do |k,v|
        Comment.create(user_id: user_id, commentable_type: "Delivery", commentable_id: k, content: v)
      end
    end
  end
end
