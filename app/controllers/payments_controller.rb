class PaymentsController < ApplicationController
  depends_on_feature :payments
  before_filter :initialize_stripe, only: :create

  def new

  end

  def create
    begin
      charge = Stripe::Charge.create(
        amount: params[:contribution].to_f,
        currency: 'usd',
        card: params[:stripeToken],
        description: 'Donation to bartendr.me'
      )
      redirect_to root_url, notice: 'Donation successful.  Thank you!'
    rescue Stripe::CardError => e
      flash[:error] = e.message
      render :tipjar
    end
  end

  private

  def initialize_stripe
    Stripe.api_key = ENV['SECRET_KEY']
  end
end
