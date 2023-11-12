require 'rails_helper'

describe RecipesService do
  before :each do
    @recipes = RecipesService.new
  end

  context 'helper methods' do
    describe '#conn' do
      it 'returns a faraday connection' do
        expect(@recipes.conn).to be_a Faraday::Connection
      end
    end
  end

  context 'class methods' do
    describe '#country_recipes' do
      it 'returns recipes by county', :vcr do
      india = @recipes.country_recipes('india')

      expect(india).to be_a Hash
      expect(india).to have_key :hits

      india_details = india[:hits]

      expect(india_details).to be_an Array
      expect(india_details.first).to be_a Hash
      expect(india_details.first).to have_key :recipe

      first_recipe = india_details.first[:recipe]

      expect(first_recipe).to have_key :label
      expect(first_recipe[:label]).to be_a String

      expect(first_recipe).to have_key :url
      expect(first_recipe[:url]).to be_a String

      expect(first_recipe).to have_key :image
      expect(first_recipe[:image]).to be_a String
      end
    end
  end
end