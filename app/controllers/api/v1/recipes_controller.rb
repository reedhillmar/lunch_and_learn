class Api::V1::RecipesController < ApplicationController
  def index
    if params[:country] == 'random'
      params[:country] = CountryService.new.random_country
      render json: RecipeSerializer.new(make_recipes(country_recipes(params[:country]), params[:country]))
    elsif params[:country]
      render json: RecipeSerializer.new(make_recipes(country_recipes(params[:country]), params[:country]))
    end
  end

  private

  def country_recipes(country)
    RecipesService.new.country_recipes(country)[:hits]
  end

  def make_recipes(recipes, country)
    recipes.map do |recipe|
      Recipe.new(recipe, country)
    end
  end
end