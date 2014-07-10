require 'rails_helper'

describe 'restaurant listings page' do
	context 'no restaurants' do
		it 'tells me there are no restaurants'do
			visit '/restaurants'
			expect(page).to have_content 'No restaurants yet'
		end
	end

	context 'are restaurants' do
		before do
			Restaurant.create(name: 'Ledbury')
		end

		it 'should show restaurant' do
			visit 'restaurants'
			expect(page).to have_content 'Ledbury'
		end
	end
end