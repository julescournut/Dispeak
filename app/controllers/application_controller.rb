class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  protect_from_forgery with: :null_session
	
	before_action :configure_permitted_parameters, if: :devise_controller?

	def api 
		respond_to do |format| 
			format.json { render json: {some: 'data'} } 
		end 
	end
	
	protected
	
	def configure_permitted_parameters
		added_attrs = [:name, :email, :password, :password_confirmation]
		devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	end
end
