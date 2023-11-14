# Lunch and Learn

This app will allow users to search for recipes by country, favorite recipes, and learn more about a particular country.

## Learning Goals

- Expose an API that aggregates data from multiple external APIs
- Expose an API that requires an authentication token
- Implement Basic Authentication
- Expose an API for CRUD functionality
- Determine completion criteria based on the needs of other developers
- Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

## Getting Started

### APIs
- Edamam API: https://api.edamam.com/
- REST Countries API: https://restcountries.com/
- Pexels API: https://www.pexels.com/api/
- YouTube Data API: https://developers.google.com/youtube/v3

### Setup

This app uses Ruby 3.2.2 and Rails 7.0.x. 

- Fork and Clone this repo
- Enter `bundle install` in the terminal to install gems
- Enter `rails db:{create, migrate}` in the terminal to create the database and update the schema
- Enter `rails s` in the terminal to start the rails server. The server can be accessed at `localhost:3000`

## Running the tests

This app uses RSpec for testing.

- To run the test, enter `bundle exec rspec` in the terminal
- Enter `open coverage/index.html` in the terminal to open the SimpleCov test coverage report

## Endpoints

### Get Recipes For A Particular Country

This endpoint returns recipes for a given country. If no country is given, it will return recipes for a random country.

```
GET /api/v1/recipes?country=thailand
Content-Type: application/json
Accept: application/json
```

### Get Learning Resources For A Particular Country

This endpoint returns learning for a given country.

```
GET /api/v1/learning_resources?country=laos
Content-Type: application/json
Accept: application/json
```

### User Registration

This endpoint registers a new user.

```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "name": "Odell",
  "email": "goodboy@ruffruff.com",
  "password": "treats4lyf",
  "password_confirmation": "treats4lyf"
}
```

### Log In User

This endpoint logs in an existing user.

```
POST /api/v1/sessions
Content-Type: application/json
Accept: application/json

{
  "email": "goodboy@ruffruff.com",
  "password": "treats4lyf"
}
```

### Add Favorite

This endpoint creates new favorite recipe for a given user.

```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy48thw9begh98h4539h4",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```

### Get a User's Favorites

This endpoint returns a given user's favorite recipes.

```
GET /api/v1/favorites?api_key=jgn983hy48thw9begh98h4539h4
Content-Type: application/json
Accept: application/json
```

## Author

  - **Reed Hillmar**
    - [GitHub](https://github.com/reedhillmar)
    - [LinkedIn](www.linkedin.com/in/reed-hillmar)