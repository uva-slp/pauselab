class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    can :manage, :pages

    # define aliases
    # alias_action :idea_collection, :to => :create
    # globally accessible actions

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
        comment.try :user == user
      end

    elsif user.super_artist?
      can :create, [Blog, Proposal, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, approved?: true
      can [:like, :show, :read], Idea, approved?: true

      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      # cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]

      can :manage, Blog do |blog|
        blog.try(:user) == user
      end
      can :manage, Proposal do |proposal|
        proposal.try(:user) == user
      end

    elsif user.artist?
      can :create, [Proposal, Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, approved?: true
      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, approved?: true
      # cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]
      # can edit proposals they own
      can :manage, Proposal do |proposal|
        proposal.try :user == user
      end

    else
      # can :read, :all
      can :create, [Idea, Vote]
      can :read, [Blog, Category]
      can :read, Proposal, approved?: true

      cannot :read, Proposal

      # cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
      cannot :manage, ProposalComment
      can [:like, :show, :read], Idea, approved?: true
      # cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]
    end

    # adjust permissions based on phase
    unless user.admin? or user.moderator?
      unless Iteration.get_current.voting?
        cannot :manage, Vote  # voting not allowed unless we are in the phase
      end
    end


    #
    # elsif user.steerer?
    #   can :read, [Blog, Category, Idea, Proposal, Vote, ProposalComment]
    #   can :manage, Proposal
    #   can [:create, :update], Idea
    #   # can create and edit proposal comments they own
    #   can :create, ProposalComment
    #   can :manage, ProposalComment do |comment|
    #     comment.try(:user) == user
    #   end
    #
    # elsif user.super_artist?
    #   can :create, [Blog, Proposal, Idea, Vote]
    #   can :read, [Blog, Category]
    #   can :read, Proposal, approved?: true
    #   cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
    #   cannot :manage, ProposalComment
    #   can [:like, :show, :read], Idea, approved?: true
    #   cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]
    #   # can edit blogs and proposals they own
    #   can :manage, Blog do |blog|
    #     blog.try(:user) == user
    #   end
    #   can :manage, Proposal do |proposal|
    #     proposal.try(:user) == user
    #   end
    #
    # elsif user.artist?
    #   can :create, [Proposal, Idea, Vote]
    #   can :read, [Blog, Category]
    #   can :read, Proposal, approved?: true
    #   cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
    #   cannot :manage, ProposalComment
    #   can [:like, :show, :read], Idea, approved?: true
    #   cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]
    #   # can edit proposals they own
    #   can :manage, Proposal do |proposal|
    #     proposal.try(:user) == user
    #   end
    #
    # else  # resident, lowest permissions
    #   can :create, [Idea, Vote]
    #   can :read, [Blog, Category]
    #   can :read, Proposal, approved?: true
    #   cannot :read, Proposal, [:status, :number_of_votes, ProposalComment]
    #   cannot :manage, ProposalComment
    #   can [:like, :show, :read], Idea, approved?: true
    #   cannot :read, Idea, [:first_name, :last_name, :phone, :email, :status]
    # end
    #


  end
end
