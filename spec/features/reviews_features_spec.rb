require 'rails_helper'

def leave_review(thoughts, rating)
	visit '/restaurants'
	fill_in 'Thoughts' , with: thoughts
	select rating , from: 'Rating'
	click_button 'Create Review'
end

describe 'writing reviews' do
	before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}
	context 'when looged out' do
		it 'should not show the review form' do
			visit '/restaurants'
			expect(page).not_to have_field('Thoughts')
		end
	end
 
end

describe 'average ratings' do
		before do
			user = User.create(email: 'fits@mail.com' , password: '12345678', password_confirmation: '12345678')
			login_as user
		end
	before {Restaurant.create name: 'KFC', cuisine: 'Chicken'}

	it 'calculates and displays the average ratings' do
		leave_review('Not great', '2')
		leave_review('Great', '4')

		expect(page).to have_content 'Average rating: ★★★☆☆'
	end
end