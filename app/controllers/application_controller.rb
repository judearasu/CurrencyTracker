class ApplicationController < ActionController::Base
	protect_from_forgery

	before_filter :authenticate_user!


	def statistic
		user_countries = UserCurrency.user_analysis(current_user)
		respond_to do |format|
			format.json{ render :json => {
				:collection => user_countries
			}
		}
	end
end
end
