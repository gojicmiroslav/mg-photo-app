class Payment < ActiveRecord::Base
	attr_accessor :card_number, :card_cvv, :card_expires_month, :card_expires_year

	belongs_to :user

	def self.month_options
		Date::MONTHNAMES.compact.each_with_index.map do |name, i|
			["#{i + 1} - #{name}", i+1]
		end
	end

	def self.year_options
		(Date.today.year..(Date.today.year + 10)).to_a		
	end

	def process_payment
		customer = Stripe::Customer.create(email: email, source: token)
		Stripe::Charge.create(customer: customer.id,
													amount: 1000, # 1000cents = $10
													description: 'Premium',
													currency: 'usd')
	end

end
