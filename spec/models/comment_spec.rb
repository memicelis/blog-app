require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:test_user) do
    User.create(
      name: 'Elis',
      photo: 'https://avatars.githubusercontent.com/u/7747059?v=4',
      posts_counter: 6,
      bio: 'Full-stack web developer'
    )
  end

  let(:test_post) do
    Post.create(
      author: test_user,
      title: 'Post one',
      text: 'Post',
      comments_counter: 0,
      likes_counter: 0
    )
  end
  let(:comment1) do
    Comment.new(
      user: test_user,
      post: test_post,
      text: 'Comment one'
    )
  end
  describe '#methods' do
    it 'update_comments_counter increments the post\'s comments_counter' do
      comment1.save
      expect(test_post.comments_counter).to eq(1)
    end
  end
end
