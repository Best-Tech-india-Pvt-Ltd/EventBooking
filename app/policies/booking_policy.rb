class BookingPolicy < ApplicationPolicy
  def create?
    user.customer?
  end

  def destroy?
    user.customer? && record.customer == user
  end
end
