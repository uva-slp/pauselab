class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, :pages

    # define aliases
    # alias_action :idea_collection, :to => :create

    if user.admin?
      can :manage, :all

    elsif user.moderator?
      can :manage, [Blog, Category, Idea, Proposal, MassEmail, Vote, ProposalComment]

    elsif user.steerer?
      can :read, [Blog, Category, Idea, Proposal, Vote, ProposalComment]
      can :manage, Proposal
      can [:create, :update], Idea
      can :create, ProposalComment
      can :manage, ProposalComment do |comment|
        comment.try :user == user   # comments owned by user
      end

    elsif user.super_artist?
      can :create, [Blog, Proposal, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, status: :approved
      can [:like, :show, :read], Idea, status: :approved

      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      can :manage, Blog do |blog|
        blog.try(:user) == user   # blogs owned by user
      end
      can :manage, Proposal do |proposal|
        proposal.try(:user) == user   # proposals owned by user
      end

    elsif user.artist?
      can :create, [Proposal, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, status: :approved
      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, status: :approved
      can :manage, Proposal do |proposal|
        proposal.try :user == user  # proposals owned by user
      end

    else
      can :create, [Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, status: :approved
      cannot :read, Proposal
      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, status: :approved
    end

    # adjust permissions based on phase
    unless user.admin? or user.moderator?
      unless Iteration.get_current.voting?
        cannot :manage, Vote  # voting not allowed unless we are in the phase
      end
    end
  end
end
