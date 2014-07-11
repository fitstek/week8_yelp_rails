require 'rails_helper'

RSpec.describe Restaurant, :type => :model do
  describe '#average_rating' do
  	let(:kfc) {Restaurant.create name: 'KFC', cuisine: 'chicken'}

  	it 'returns N/A if there are no reviews' do
  		expect(kfc.average_rating).to eq 'N/A'
  	end

  	context 'with one review' do
	  	it ' return the number' do
	  		kfc.reviews.create(rating: 3)
	  		expect(kfc.average_rating).to eq 3
	  	end
  	end

   	context 'with multiple reviews' do
	  	it ' returns the average of the two numbers' do
	  		kfc.reviews.create(rating: 3)
	  		kfc.reviews.create(rating: 5)
	  		expect(kfc.average_rating).to eq 4
	  	end
  	end
     	context 'average rating is a decimal number' do
	  	it ' returns the average rating as a float' do
	  		kfc.reviews.create(rating: 2)
	  		kfc.reviews.create(rating: 5)
	  		expect(kfc.average_rating).to eq 3.5
	  	end
  	end
  end
end
