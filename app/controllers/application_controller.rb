class ApplicationController < ActionController::Base
	helper_method :current_user, :logged_in?

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

	def logged_in?
		!!current_user
	end

	def require_user
		if !logged_in?
			flash[:danger] = "You must be logged in to perform the action!"
			redirect_to root_path
		end
	end

	def require_same_user
		if current_user != @article.user
			flash[:danger] = "You can only edit or delete your own articles!"
			redirect_to root_path
		end
	end

end
