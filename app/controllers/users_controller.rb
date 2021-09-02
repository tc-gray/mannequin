class UsersController < ApplicationController
  def show
    @user = current_user
    @pending_bookings = Booking.where(status: "Pending")
  end

  def profile
    @user = User.find(params[:id])
  end
end
