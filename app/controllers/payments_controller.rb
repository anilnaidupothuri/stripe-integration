class PaymentsController < ApplicationController
	def get_cards 
		cards = Stripe::Customer.list_sources(Customer.first.stripe_id,{object: 'card'},)
		render json: cards
	end

   def create 
   	order = Order.find(params[:order_id])
   	
     token = Stripe::Token.create({
      card: {
        number: params[:credit_card_number],
        exp_month: params[:credit_card_exp_month],
        exp_year: params[:credit_card_exp_year],
        cvc: params[:credit_card_cvv],
      }
    })
     source = Stripe::Customer.create_source(Customer.last.stripe_id, {source: token})

     payment = Stripe::PaymentIntent.create({amount: order.amount*100, currency: 'inr', payment_method_types: ['card'], payment_method:source.id, customer: Customer.last.stripe_id})
     transaction = Transaction.create(amount: order.amount, order_id: order.id, status: payment.status, stripe_payment_id:payment.id)
     render json: {payment: payment, transaction: transaction}
   end

  def payment_confirm
 
  	payment_intent = Stripe::PaymentIntent.retrieve(
  		params[:payment_id])
  	 # payment_intent.confirm

 

 # if payment_intent.next_action.present?
 #  # The payment requires additional action
 #  render json: "Payment requires action: #{payment_intent.next_action.type}"
 #  # Follow the instructions in the `payment_intent.next_action` object
# 	# else
# 	#   # The payment is completed
# 	#   puts "Payment is completed"
# 	end

	#  begin
	#   payment_intent = Stripe::PaymentIntent.confirm(payment_intent.client_secret)
	#   # PaymentIntent is confirmed
	# rescue Stripe::CardError => e
	#   # Display error message to user
	#   puts "Error: #{e.message}"
	# rescue Stripe::StripeError => e
	#   # Display generic error message to user
	#   puts "Error: #{e.message}"
	# end
	 if payment_intent.status == 'requires_confirmation'
    # If so, confirm the PaymentIntent with the client_secret
    payment_intent = Stripe::PaymentIntent.confirm(payment_intent.id)
    transaction = Transaction.where(stripe_payment_id:payment_intent.id ).last
    transaction.update(status: payment_intent.status)
     render json: payment_intent
  else
    render json: {message: "PaymentIntent already confirmed", payment: payment_intent}
  end

  end
end