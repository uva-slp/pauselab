class Ability
  include CanCan::Ability

  def initialize(user)
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

    if user.admin?
      can :manage, :all
    elsif user.moderator?
      can :manage, [Blog, Category, Idea, Proposal]
    elsif user.steerer?
      can :read, [Blog, Category, Idea, Proposal]
      can :manage, Proposal
      can :update, Idea
      can :create, Idea
      can :idea_collection, Idea
    elsif user.artist?
      # can edit blogs and proposals they own
      can :manage, Blog do |blog|
        blog.try(:user) == user
      end
      can :manage, Proposal do |proposal|
        proposal.try(:user) == user
      end
      can :create, [Blog, Proposal, Idea]
      can :read, [Blog, Category, Proposal]
      can :read, Idea, approved?: true
      can :create, Idea
      can :idea_collection, Idea
      can :like, Idea
      can :show, Idea
    else  # resident, lowest permissions
      can :read, [Blog, Category, Proposal]
      can :read, Idea, approved?: true
      can :create, Idea
      can :idea_collection, Idea  #TODO eliminate redundancy between create and idea_collection
      can :like, Idea
      can :show, Idea
    end

  end
end
