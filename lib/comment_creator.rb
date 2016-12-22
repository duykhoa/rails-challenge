class CommentCreator
  def create(comment_params, user_id)
    comment_params[:order_item].each do |k,v|
      Comment.create(user_id: user_id, commentable_type: "OrderItem", commentable_id: k, content: v)
    end

    comment_params[:delivery].each do |k,v|
      Comment.create(user_id: user_id, commentable_type: "Delivery", commentable_id: k, content: v)
    end
  end
end
