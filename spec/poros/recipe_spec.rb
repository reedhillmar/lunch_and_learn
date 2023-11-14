require 'rails_helper'

describe Recipe do
  it 'exists' do
    data = {
      recipe: {
        label: 'recipe title',
        url: 'recipe url',
        image: 'recipe image'
      }
    }

    recipe = Recipe.new(data, 'thailand')

    expect(recipe).to be_a Recipe
    expect(recipe.title).to eq('recipe title')
    expect(recipe.url).to eq('recipe url')
    expect(recipe.country).to eq('thailand')
    expect(recipe.image).to eq('recipe image')
  end
end