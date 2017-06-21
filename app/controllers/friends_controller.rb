class FriendsController < ApplicationController
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
end
