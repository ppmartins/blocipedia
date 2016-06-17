class ChargesController < ApplicationController
  def create
    # Creates a Stripe Customer object, for associating
    # with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id, # Note -- this is NOT the user_id in your app
      amount: Amount.default,
      description: "Blocipedia Premium Membership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you, #{current_user.email}! It's great to have you on board."
    redirect_to wikis_path(current_user) # or wherever

    # upgrade user role to premium
    current_user.premium!

    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path

    # if the card is declined they are back to member
    current_user.member!
  end

  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Blocipedia Premium Membership - #{current_user.email}",
      amount: Amount.default
    }
  end
end
