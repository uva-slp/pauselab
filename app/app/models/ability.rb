class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, :pages

    # define aliases
    alias_action :proposal_collection, :to => :read

    if user.admin?
      can :manage, :all

    elsif user.moderator?
      can :manage, [Blog, Category, Idea, Proposal, ProposalBudget, \
        MassEmail, Vote, ProposalComment, Landingpage, Iteration]

    elsif user.steerer?
      can :create, [Proposal, ProposalBudget, Idea, Vote]
      can :read, [Blog, Category, Idea, Proposal, ProposalBudget, Vote, ProposalComment, Iteration]
      can [:read, :update], Proposal
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      can [:create, :update], Idea
      can :create, ProposalComment
      can :manage, ProposalComment, user: user

    elsif user.super_artist?
      can :create, [Blog, Proposal, ProposalBudget, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      can [:like, :show, :read], Idea, status: Idea.statuses[:approved]
      cannot :manage, ProposalComment
      can :manage, Blog, user: user
      can :manage, Proposal, user: user

    elsif user.artist?
      can :create, [Proposal, ProposalBudget, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, status: Idea.statuses[:approved]
      can :manage, Proposal, user: user

    else
      can :create, [Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal
      cannot :read, Proposal, status: Proposal.statuses[:unchecked]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, status: Idea.statuses[:approved]
    end

    # adjust permissions based on phase
    unless user.admin? or user.moderator?
      unless Iteration.get_current.voting?
        cannot :manage, Vote  # voting not allowed unless we are in the phase
      end
    end
  end
end
