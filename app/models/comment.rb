class Comment < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, class_name: 'Post', foreign_key: 'post_id'

  validates :text, length: { minimum: 1 }

  def update_comments_counter
    post.increment!(:comments_counter)
  end

  def update_comments_counter_after_destroy
    post.decrement!(:comments_counter)
  end

  after_save :update_comments_counter
  after_destroy :update_comments_counter_after_destroy
end
