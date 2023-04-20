class OrdersController < ApplicationController

	def create 
		@order = Order.new(order_params)
		if @order.save 
			render json: {order:@order, payment: @order.payment}, status: :created
		else 
			render json: @order.errors 
		end
end
		private 
		 def order_params
		 	params.require(:order).permit(:customer_id, :amount )

		 end 

	 
end
