# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    can :read, Post
    return unless user.present?

    can :manage, Post, author: user
    can :create, Comment
    can :manage, Comment, post: { author: user}

    return unless user.admin?
    can :manage, :all
  end
end
