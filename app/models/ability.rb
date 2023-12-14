class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    # Define User abilities
    if user.is? :admin
      can :manage, :all
    elsif user.is? :default
      can :read, Post
      can :manage, Post, author: user
      can :create, Comment
      can %i[read destroy], Comment, user_id: user.id
      can :manage, Comment, post: { author: user }
    else
      can :read, Post
    end
  end
end
