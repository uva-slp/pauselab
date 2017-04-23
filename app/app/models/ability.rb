class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, user   # any user can manage its own data

    # define aliases
    alias_action :proposal_collection, :to => :read
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can :manage, :all

    elsif user.moderator?
      can :manage, [Blog, Category, Idea, Proposal, ProposalBudget, \
        MassEmail, Vote, ProposalComment, Landingpage, Iteration]

    elsif user.steerer?
      can :create, [Blog, Proposal, ProposalBudget, ProposalComment, Idea, Vote]
      can :read, [Blog, Category, Idea, Proposal, ProposalBudget, ProposalComment, Vote, Iteration]
      can :update, [Proposal, Idea]
      can :like, Idea
      can :crud, Blog, user: user
      can :crud, ProposalComment, user: user
      can :crud, Proposal, user: user

    elsif user.super_artist?
      can :create, [Blog, Proposal, ProposalBudget, Idea, Vote]
      can :read, [Blog, Category, Idea, Proposal, ProposalBudget]
      can :like, Idea
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      cannot [:read, :like], Idea, status: Idea.statuses[:unchecked]
      can :crud, Blog, user: user
      can :crud, Proposal, user: user

    elsif user.artist?
      can :create, [Proposal, ProposalBudget, Idea, Vote]
      can :read, [Blog, Category, Idea, Proposal, ProposalBudget]
      can :like, Idea
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      cannot [:read, :like], Idea, status: Idea.statuses[:unchecked]
      can :crud, Proposal, user: user

    else  # resident
      can :create, [Idea, Vote]
      can :read, [Blog, Category, Idea, Proposal, ProposalBudget]
      can :like, Idea
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      cannot [:read, :like], Idea, status: Idea.statuses[:unchecked]
    end

    # adjust permissions based on phase
    unless user.admin? or user.moderator?
      unless Iteration.get_current.voting?
        cannot :manage, Vote  # voting not allowed unless we are in the phase
      end
    end
  end
end
