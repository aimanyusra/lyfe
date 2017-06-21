class StaticController < ApplicationController
	def index
		render 'static/index'

		@style = Style.all
	end
end
