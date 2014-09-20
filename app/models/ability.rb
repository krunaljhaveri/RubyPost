class Ability
  include CanCan::Ability

  def initialize(user)
    # Defines abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities

    unless user.nil?

      # Can manage his post
      can :manage, Post do |p|
        p.user == user
      end
      can :create, Post

      # Can manage his comments
      can :manage, Comment do |c|
        c.user == user
      end

      can :create, Comment

      # Can vote if allowed
      can :create, Vote do |v|
        voting_for_self = true
        already_voted = true
        if v.voteable_type == 'Post'
          voting_for_self = (Post.find(v.voteable_id).user == user)
          already_voted = !(Vote.where('voteable_type = "Post" AND voteable_id = ? AND user_id = ?', v.voteable_id, user).empty?)
        elsif v.voteable_type == 'Comment'
          voting_for_self = (Comment.find(v.voteable_id).user == user)
          already_voted = !(Vote.where('voteable_type = "Comment" AND voteable_id = ? AND user_id = ?', v.voteable_id, user).empty?)
        end
        !voting_for_self and !already_voted
      end

      if user.admin?

        # Admin can delete any post or comment
        can :destroy, [Post, Comment]

        # Admin can create Categories
        can :manage, Category

        # Admin can manage other users
        can :manage, User

        # Admin cannot manage other Admins and Super Admin
        cannot :manage, User do |u|
          u.admin? or u.super_admin?
        end

        # Admin can manage himself
        can :manage, User do |u|
          u == user
        end

        can :administer, User do |u|
          u.admin == true
        end

      end

      # Super admin can manage everything
      if user.super_admin?

        # Super admin can delete any post or comment
        can :destroy, [Post, Comment]

        # Super admin can create Categories
        can :manage, Category

        # Super admin can manage other users
        can :manage, User

        # Super admin cannot manage himself
        cannot :manage, User do |u|
          u == user
        end

        can :administer, User do |u|
          u.super_admin == true
        end
      end
    end

    # Any user can read everything
    can :read, :all

    # Guest can register
    can :create, User

  end
end
