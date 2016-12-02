class Ability
  include CanCan::Ability

  def initialize(user)
    # NOTE using CanCan 2.0, some of the below comments are deprecated
    # Define abilities for the passed in user here. For example:
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

    # if user not logged in, create guest user
    user ||= User.new
    #if user.nil?
      #user = User.new
      #user.role = :resident
    #end

    # define aliases
    alias_action :idea_collection, :to => :create

    # globally accessible actions
    can :access, :pages

    if user.admin?
      can :access, :all
    elsif user.moderator?
      can :access, [:blogs, :categories, :ideas, :proposals, :mass_emails, :votes]
    elsif user.steerer?
      can :read, [:blogs, :categories, :ideas, :proposals, :votes]
      can :access, :proposals
      can [:create, :update], :ideas
    elsif user.super_artist?
      can :create, [:blogs, :proposals, :ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes]
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
      # can edit blogs and proposals they own
      can :access, :blogs do |blog|
        blog.try(:user) == user
      end
      can :access, :proposals do |proposal|
        proposal.try(:user) == user
      end
    elsif user.artist?
      can :create, [:proposals, :ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes]
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
      # can edit proposals they own
      can :access, :proposals do |proposal|
        proposal.try(:user) == user
      end
    else  # resident, lowest permissions
      can :create, [:ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes]
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
    end

  end
end
