class Ability
  include CanCan::Ability

  def initialize user
    can :read, :all
    return unless user.present?
    can :manage, GreenAct, user_id: user.id
  end
end
