class Ability
  include CanCan::Ability

  def initialize(user)

    if user.role == 'Admin'
      can :manage, :all
    else
      can :read, Sale
      can :update, Sale, status: { access: 2..4 }
      can :create, Sale
      can :destroy, Sale, status: { access: 4 }

      can :manage, Property
      can :manage, Rental
      can :manage, Comment

      readble_entities = %w{Address Agent AgentProperty Attorney Bank Deductable Originator Status}

      readble_entities.each do |r|
        can :read, r.constantize
      end
    end

    #can :manage, :all
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
