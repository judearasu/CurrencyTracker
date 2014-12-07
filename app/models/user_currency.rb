class UserCurrency < ActiveRecord::Base
	attr_accessible :currency_code, :user_id
	self.include_root_in_json = false

	belongs_to :user
	belongs_to :currency, :foreign_key => :currency_code

	validates :user, :presence => true, :allow_blank => false
	validates :currency, :presence => true, :allow_blank => false

	scope :user_analysis, lambda{ |user| where(:user_id => user.id).
		select("strftime( '%d.%m.%Y', created_at) as date, count(*) as cnt").
		group("date") }
	end
