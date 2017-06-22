class ComparesController < ApplicationController
	def show
		@user = User.find(params[:id])
		byebug
	end
end
