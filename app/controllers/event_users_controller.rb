class EventUsersController < ApplicationController
	def show
		EventUser.create(event_id: params[:id], user_id: current_user.id)
		redirect_to events_path
	end
	# used show because it has /:id as params
	# looks like no need strong params if not using form_for

	def destroy
		@attendence = EventUser.where(event_id: params[:id])
		@attendence = @attendence.where(user_id: current_user.id)
		@attendence[0].destroy
		redirect_to events_path
	end

	def edit
		# just using this for making favorites
	end

	def update
		Favorite.create(user_id: current_user.id, object: 'event', objectid: params[:id])
		redirect_to events_path
	end
end
