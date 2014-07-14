class RestaurantsController < ApplicationController

	before_action :authenticate_user!, except: [:index]

	def index
		@restaurants = Restaurant.all
		@review = Review.new
	end

	def new
		@restaurant = Restaurant.new
	end

	def create
		@restaurant = Restaurant.new restaurant_params
		@restaurant.user = current_user

		if @restaurant.save
			redirect_to '/restaurants'
		else
			render 'new'
		end
	end

	def edit
		@restaurant = current_user.restaurants.find(params[:id])
		rescue ActiveRecord::RecordNotFound
		flash[:notice] = 'Not one of your restaurants'
		redirect_to '/restaurants'
	end

	def update
		@restaurant = current_user.restaurants.find(params[:id])
		
		if @restaurant.update restaurant_params
			redirect_to '/restaurants'
		else
			render 'new'
		end
	end

	def destroy
		@restaurant = current_user.restaurants.find(params[:id])
		@restaurant.destroy
		flash[:notice] = "#{@restaurant.name} successfully deleted"

	rescue ActiveRecord::RecordNotFound
		flash[:notice] = 'Not one of your restaurants'
		ensure
		redirect_to '/restaurants'
	end

	# another way if we want to refarctor instead of params[:restaurant].permit(:name)
	private

	def restaurant_params
		params[:restaurant].permit(:name, :cuisine)
	end
end
