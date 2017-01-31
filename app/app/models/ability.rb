class Ability
  include CanCan::Ability

  def initialize(user)
    # if user not logged in, create guest user
    user ||= User.new
    # define aliases
    alias_action :idea_collection, :to => :create
    # globally accessible actions
    can :manage, :pages

    if user.admin?
      can :manage, :all

    elsif user.moderator?
      can :manage, [:blogs, :categories, :ideas, :proposals, :mass_emails, :votes, :proposal_comments]

    elsif user.steerer?
      can :read, [:blogs, :categories, :ideas, :proposals, :votes, :proposal_comments]
      can :manage, :proposals
      can [:create, :update], :ideas
      # can create and edit proposal comments they own
      can :create, :proposal_comments
      can :manage, :proposal_comments do |comment|
        comment.try(:user) == user
      end

    elsif user.super_artist?
      can :create, [:blogs, :proposals, :ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes, :proposal_comments]
      cannot :manage, :proposal_comments
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
      # can edit blogs and proposals they own
      can :manage, :blogs do |blog|
        blog.try(:user) == user
      end
      can :manage, :proposals do |proposal|
        proposal.try(:user) == user
      end

    elsif user.artist?
      can :create, [:proposals, :ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes, :proposal_comments]
      cannot :manage, :proposal_comments
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
      # can edit proposals they own
      can :manage, :proposals do |proposal|
        proposal.try(:user) == user
      end

    else  # resident, lowest permissions
      can :create, [:ideas, :votes]
      can :read, [:blogs, :categories]
      can :read, :proposals, approved?: true
      cannot :read, :proposals, [:status, :number_of_votes, :proposal_comments]
      cannot :manage, :proposal_comments
      can [:like, :show, :read], :ideas, approved?: true
      cannot :read, :ideas, [:first_name, :last_name, :phone, :email, :status]
    end

    # adjust permissions based on phase
    unless user.admin? or user.moderator?
      unless Phase.get_current.voting?
        cannot :manage, :votes  # voting not allowed unless we are in the phase
      end
    end

  end
end
