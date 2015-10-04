class UsersController < ApplicationController
	before_action :set_user

	def show
	end

	protected
	def set_user
		@user = User.find(params[:id])
	end

end
