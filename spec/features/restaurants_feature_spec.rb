require 'rails_helper'

describe 'restaurant listings page' do
	context 'no restaurants' do
		it 'tells me there are no restaurants'do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants yet'
		end
	end

	context 'when there are restaurants' do
		before do
			Restaurant.create(name: 'Ledbury', cuisine: 'french')
		end

		it 'should show restaurant' do
			visit '/restaurants'
			expect(page).to have_content 'Ledbury'
		end
	end
end

describe 'restaurant creation form' do

	it 'takes us to the sign up page' do
		visit '/restaurants'
		click_link 'Create a restaurant'

		expect(page).to have_content 'Sign up'
	end
	context 'When user is logged in' do
			before do
			user = User.create(email: 'fits@mail.com' , password: '12345678', password_confirmation: '12345678')
			login_as user
		end
		context 'input is valid' do
			it'should be able to create a restaurant' do
				visit 'restaurants/new'
				fill_in 'Name', with: 'Burger King'
				fill_in 'Cuisine', with: 'Fast Food'
				click_button 'Create Restaurant'

				expect(current_path).to eq '/restaurants'
				expect(page).to have_content 'Burger King (Fast Food)'
			end
		end

		context 'input is not  valid' do
			it'should not to be able to create a restaurant' do
				visit 'restaurants/new'
				fill_in 'Name', with: 'burger king'
				fill_in 'Cuisine', with: 'ff'
				click_button 'Create Restaurant'

				expect(current_path).to eq '/restaurants'
				expect(page).to have_content 'errors'
				expect(page).not_to have_content 'burger king (ff)'
			end
		end
	end
end

describe 'restaurant editing and deleting' do
	before {Restaurant.create name: 'KFC', cuisine: 'Chicken'} 
	context 'when logged out ' do
		it 'should not have allow user to edit restaurant' do
			visit '/restaurants'
			expect(page).not_to have_content 'Edit KFC' 
		end

		it 'should not have allow user to delete restaurant' do
			visit '/restaurants'
			expect(page).not_to have_content 'Delete KFC' 
		end		
	end
	context 'When looged in' do
		before do
			user = User.create(email: 'fits@mail.com' , password: '12345678', password_confirmation: '12345678')
			login_as user
		end
		context 'with valid data' do
			it 'should be able to edit the restaurant' do
				visit '/restaurants'
				click_link 'Edit KFC'

				fill_in 'Name' , with: 'Kentucky Fried Chicken'

				click_button 'Update Restaurant'

				expect(current_path).to eq '/restaurants'
				expect(page).to have_content 'Kentucky Fried Chicken'
			end
		end
		context 'with invalid data' do
			it 'should not be able to edit the restaurant and should show error message' do
				visit '/restaurants'
				click_link 'Edit KFC'

				fill_in 'Name' , with: 'kfc'

				click_button 'Update Restaurant'

				expect(page).to have_content 'error'
			end
		end	

		it 'can delete restaurants' do
			visit '/restaurants'
			click_link'Delete KFC'

			expect(page).not_to have_content 'KFC (Chicken)'
			expect(page).to have_content 'KFC successfully deleted'
		end
	end	
end