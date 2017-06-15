class EventUsersController < ApplicationController
	def show
		EventUser.create(event_id: params[:id], user_id: current_user.id)
		redirect_to events_path
	end
end
