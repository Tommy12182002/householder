class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
	# Deviseでログイン・サインアップ時に引き渡すパラメータの追加処理
  protect_from_forgery with: :exception
	before_action :configure_premitted_parameters, if: :devise_controller?
	
	# Deviseでログイン後にリダイレクトされる先を変更(override)
	def after_sign_in_path_for(resource)
		d = Date.today
		user_journal_month_path(current_user, d.year, d.month)
	end

	protected
	def configure_premitted_parameters
		devise_parameter_sanitizer.for(:sign_up) << :name
		devise_parameter_sanitizer.for(:sign_in) << :name
		devise_parameter_sanitizer.for(:account_update) << :name
	end
end
