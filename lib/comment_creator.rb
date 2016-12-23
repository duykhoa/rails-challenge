class CommentCreator
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
