class OrdersController < ApplicationController
  def create
    booking = Booking.find(params[:booking_id])
    order = Order.create!(booking: booking, amount: booking.product.price, state: 'pending', user: current_user)

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{ name: booking.product.name.parameterize,
        images: [Cloudinary::Utils.cloudinary_url(booking.product.photos.first.key)],
        amount: booking.product.price_cents,
        currency: 'gbp',
        quantity: 1
      }],
      success_url: root_path,
      cancel_url: user_path(current_user)
    )

    order.update(checkout_session_id: session.id)
    # redirect_to new_order_payment_path(order)
    # redirect_to user_path(current_user)
  end

  def show
    redirect_to root_path
  end

  # def mark_as_paid
  #   order = Order.find_by(checkout_session_id: event.data.object.id)
  #   order.update(state: 'Paid')
  # end
end
