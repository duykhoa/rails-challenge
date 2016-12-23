require 'rails_helper'

describe CommentCreator do
  describe "#create" do
    it do
      user = User.create(email: "test@gmail.com", password: "abcdefghikl")
      comment_params = {
        order_item: {
          1 => 'this is comment'
        },
        delivery: {
        }
      }

      CommentCreator.new.create(comment_params, user.id)

      expect(Comment.count).to eq 1
    end

    it "create comment for delivery" do
      user = User.create(email: "test@gmail.com", password: "abcdefghikl")
      comment_params = {
        order_item: {
        },
        delivery: {
          5 => "delivery comment"
        }
      }

      CommentCreator.new.create(comment_params, user.id)

      expect(Comment.count).to eq 1
    end


    it "lack of params" do
      user = User.create(email: "test@gmail.com", password: "abcdefghikl")
      comment_params = {}

      expect do
        CommentCreator.new.create(comment_params, user.id)
      end.not_to raise_error
    end

    it "order_item & delivery's comments are nil" do
      user = User.create(email: "test@gmail.com", password: "abcdefghikl")
      comment_params = {
        order_item: nil,
        delivery: nil
      }
      expect do
        CommentCreator.new.create(comment_params, user.id)
      end.not_to raise_error
    end
  end
end
