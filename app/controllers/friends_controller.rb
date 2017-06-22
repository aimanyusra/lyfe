class FriendsController < ApplicationController
	def index
		byebug
	end

	def show
		Friend.create(firstid: current_user.id, secondid: params[:id], status: 0)
		redirect_to events_path
	end

	def edit
		@friend = Friend.find(params[:id])
		@friend.status = 1
		@friend.save
		byebug
		redirect_to events_path
	end

	def update
		@user = User.find(params[:id])
		redirect_to compare_path(params[:id])
	end
end
