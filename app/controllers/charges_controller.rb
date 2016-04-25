class ChargesController < ApplicationController
before_action :authenticate_user!

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
      #Ask Jon about Amount class -> Amount.default
      amount: default_amount,
      description: "BigMoney Membership - #{current_user.name}",
      currency: 'usd'
    )
# byebug
    current_user.role = "premium"
    if current_user.save
      flash[:notice] = "Thanks for all the money, #{current_user.email}! your account has been upgraded to Premium"
    else
      flash[:notice] = "Error taking your money, #{current_user.email}! your account has been upgraded to Premium"
    end
    redirect_to wikis_path # or wherever
    # Stripe will send back CardErrors, with friendly messages
    # when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  def new
   @stripe_btn_data = {
     key: "#{ Rails.configuration.stripe[:publishable_key] }",
     description: "BigMoney Membership - #{current_user.name}",
     amount: default_amount
   }
  end

  private

  def default_amount
    10_00
  end

end
