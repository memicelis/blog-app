require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'Test User') }
  subject { Post.new(author: user, title: 'My Post', comments_counter: 5, likes_counter: 5) }
  before { subject.save }

  describe 'validations' do
    it 'should be valid' do
      expect(subject).to be_valid
    end

    it 'requires a title' do
      subject.title = nil
      expect(subject).not_to be_valid
    end

    it 'requires a title not longer than 250 characters' do
      subject.title = 'test' * 100
      expect(subject).not_to be_valid
    end

    it 'requires comments_counter to be an integer greater than or equal to zero' do
      subject.comments_counter = -1
      expect(subject).not_to be_valid

      subject.comments_counter = 'string'
      expect(subject).not_to be_valid
    end

    it 'requires likes_counter to be an integer greater than or equal to zero' do
      subject.likes_counter = -1
      expect(subject).not_to be_valid

      subject.likes_counter = 'string'
      expect(subject).not_to be_valid
    end
  end

  describe '#methods' do
    let!(:comment1) { Comment.create(user:, post: subject, text: 'Comment one') }
    let!(:comment2) { Comment.create(user:, post: subject, text: 'Comment two') }
    let!(:comment3) { Comment.create(user:, post: subject, text: 'Comment three') }
    let!(:comment4) { Comment.create(user:, post: subject, text: 'Comment four') }
    let!(:comment5) { Comment.create(user:, post: subject, text: 'Comment five') }
    let!(:comment6) { Comment.create(user:, post: subject, text: 'Comment six') }

    it 'recent_comments returns 5 posts at descending order' do
      expect(subject.recent_comments).to eq([comment6, comment5, comment4, comment3, comment2])
    end

    it 'update_posts_counter method increments the author\'s posts_counter' do
      expect { subject.update_posts_counter }.to change { user.reload.posts_counter }.by(1)
    end
  end
end
