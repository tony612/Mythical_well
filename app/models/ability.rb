class Ability
  include CanCan::Ability

  def initialize(user)
    if user.blank?
      # not logged in
      cannot :manage, :all
      basic_read_only
    elsif user.has_role?(:admin)
      # admin
      can :manage, :all
    elsif user.has_role?(:member)
      # Event
      can :create, Event
      can :follow, Event
      can :unfollow, Event
      can :update, Event do |event|
        (event.user_id == user.id)
      end
      can :destroy, Event do |event|
        (event.user_id == user.id)
      end

      # Comment
      can :create, Comment
      can :update, Comment do |comment|
        (comment.user_id == user.id)
      end
      can :destroy, Comment do |comment|
        (comment.user_id == user.id)
      end

      # Follow Ship
      can :create, Followship
      can :destroy, Followship

      # Message
      can :read, Message do |msg|
        (msg.user_id == user.id)
      end
      can :destroy, Message do |msg|
        (msg.user_id == user.id)
      end
      can :empty, Message do |msg|
        (msg.user_id == user.id)
      end

      # User
      can :follow, User
      can :unfollow, User

    else
      cannot :manage, :all
      basic_read_only
    end
  end

  protected

  def basic_read_only
    can :read, Event

    can :read, Comment

    can :read, Node
    can :read, User
  end
end
