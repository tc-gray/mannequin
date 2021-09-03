class UsersController < ApplicationController
  def show
    @pending_bookings = Booking.where(status: "Pending", user: current_user)
  end

  def profile
    @user = User.find(params[:id])
  end
end
