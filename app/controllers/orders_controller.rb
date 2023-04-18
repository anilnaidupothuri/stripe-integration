class OrdersController < ApplicationController

	def create 
		@order = Order.new(order_params.merge(amount: 1000, payment_method:'credit_card'))
		if @order.save 
			render json: {order:@order, payment: @order.payment}, status: :created
		else 
			render json: @order.errors 
		end
end
		private 
		 def order_params
		 	params.require(:order).permit(:customer_id, :credit_card_cvv, :credit_card_exp_year, :credit_card_exp_month, :credit_card_number)

		 end 

	 
end
