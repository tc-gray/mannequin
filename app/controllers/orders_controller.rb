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
      success_url: order_url(order),
      cancel_url: order_url(order)
    )

    order.update(checkout_session_id: session.id)
    # redirect_to new_order_payment_path(order)
    redirect_to user_path(current_user)
  end
end
