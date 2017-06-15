class UsersController < Clearance::UsersController
	def new
		@user = User.new  
	end

	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			redirect 'users#show'
		else
			# @user.save
			# respond_to do |format|
			# 	format.html {render template: "user/new"}
			# 	format.js 
			# end
			render template: "user/new"
		end
	end

	def index 
	end	

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		respond_to do |format|
		if @user.update(user_params)
		 format.html { redirect_to @user, notice: 'User was successfully updated.' }        
      else
        format.html { render :edit }        
      end
  	end
	end

	def show
		@user = User.find(params[:id])
		# @bookings = @user.bookings use for events
	end
	
	private
	def user_params
		params.require(:user).permit(:first_name, :last_name, :age, :email, :password)
	end
end
