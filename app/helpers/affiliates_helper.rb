module AffiliatesHelper

	def affiliate_signed_in?
		if Affiliate.all != nil
			session[:affiliate_id] != nil
		end
	end

	def current_affiliate

		if session[:affiliate_id] != nil
			@current_affiliate = Affiliate.find(session[:affiliate_id])
		end
	end
end
