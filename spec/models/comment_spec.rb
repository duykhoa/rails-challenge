require 'rails_helper'

describe Comment, type: :model do
  it "can create comment" do
    cmt = Comment.create(content: "this is a comment")
    expect(cmt.persisted?).to be true
  end
end
