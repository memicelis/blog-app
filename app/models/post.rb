class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end
  after_save :update_posts_counter
end
