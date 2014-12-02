class UserCurrency < ActiveRecord::Base
	attr_accessible :currency_code, :user_id

	belongs_to :user
	belongs_to :currency, :foreign_key => :currency_code
end
