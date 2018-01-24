module ApplicationHelper

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
	def flash_class(level)
	    case level
	        when "info" then "alert alert-info"
	        when "success" then "alert alert-success"
	        when "errors" then "alert alert-warning"
	        when "alert" then "alert alert-danger"
	    end
	end	
	
end
