class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  def update_posts_counter
    update(posts_counter: posts.count)
  end

  def recent_comments
    comments.order(created_at :desc).limit(5)
  end
end
