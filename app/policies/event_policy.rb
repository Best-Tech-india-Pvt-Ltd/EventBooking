class EventPolicy < ApplicationPolicy
  def create?
    user.event_organizer?
  end

  def update?
    user.event_organizer? && user_is_organizer?
  end

  def destroy?
    user.event_organizer? && user_is_organizer?
  end

  private

  def user_is_organizer?
    record.event_organizer == user
  end
end
