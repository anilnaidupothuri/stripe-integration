class Payment < ApplicationRecord
    attr_accessor :credit_card_number, :credit_card_exp_month, :credit_card_exp_year, :credit_card_cvv
  belongs_to :order
  before_validation :create_on_stripe
  def create_on_stripe
    token = get_token
     byebug
    params = { amount: order.amount, currency: 'inr', payment_method_types: ['card'], payment_method:token.id, customer: Customer.last.stripe_id}
    response = Stripe::PaymentIntent.create(params)
    self.stripe_id = response.id
  end
  def get_token
   token = Stripe::Token.create({
      card: {
        number: credit_card_number,
        exp_month: credit_card_exp_month,
        exp_year: credit_card_exp_year,
        cvc: credit_card_cvv,
      }
    })
  Stripe::Customer.create_source(Customer.last.stripe_id, {source: token})

  end
end
