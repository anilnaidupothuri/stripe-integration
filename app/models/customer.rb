class Customer < ApplicationRecord
  validates :stripe_id, presence: true
	has_many :orders
	before_validation :create_on_stripe, on: :create
	def create_on_stripe

		
	  params = { address: "hyd", email: email, name: name }
	  response = Stripe::Customer.create(
	  	 {
    name: name,
    email: email,
    address: {
      line1: '510 Townsend St',
      postal_code: '98140',
      city: 'San Francisco',
      state: 'CA',
      country: 'US',
    },
  },)
	  self.stripe_id = response.id
	end
end
