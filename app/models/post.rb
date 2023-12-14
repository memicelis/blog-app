class Post < ApplicationRecord
  has_many :comments
  has_many :likes
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'

  validates :title, presence: true, length: { in: 2..250 }
  validates :comments_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def update_posts_counter_after_destroy
    author.decrement!(:posts_counter)
  end
  after_save :update_posts_counter
  after_destroy :update_posts_counter_after_destroy
end
