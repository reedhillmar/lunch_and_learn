# Instructions
1. Create a branch off of your Lunch and Learn project called `final` - this branch should be in working order with at least user story 1 completed.
2. As you work, try to commit to this branch often. 
3. DO NOT push your code to your GitHub repo until the end of the 3 hour assessment. You’ll get one message that time is up, which is when you should commit/push and submit your work.
4. Complete the user story below. You should:
   - TDD all of your work
   - Prioritize getting your code functional before attempting any refactors
   - Write/refactor your code to achieve good code quality

# Assignment

You will be using the "Places API" to search for tourist sites based on the latitude-longitude of the capital city of the country that is provided by the user. Presume that your user will give a valid country (you can handle edge cases later).

Your endpoint should follow this format:

```
GET /api/v1/tourist_sites?country=France
```

Please do not deviate from the names of the endpoint or query parameters. Be sure it is called `"tourist_sites"` and `"country"`, respectively.
Your API will return:

- A collection of all found tourist sites within a 1000-meter radius of the capital city. (Use the REStful Countries API to find the lat-lon of the capital of a given country)
- Each site should list its: 
  - name
  - formatted address
  - `place_id` (also from the Place API)

Your response should be in the format below:
```
{
    "data": [
        {
            "id": null,
            "type": "tourist_site",
            "attributes": {
                "name": "Tour de l'horloge",
                "address": "Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France",
                "place_id": "51d28..."
            }
        },
        {
            "id": null,
            "type": "tourist_site",
            "attributes": {
                "name": "Le Château",
                "address": "Le Château, D 18, 23150 Ahun, France",
                "place_id": "51934..."
            }
        },
        {
            "id": null,
            "type": "tourist_site",
            "attributes": {
                "name": "Le Chapître",
                "address": "Le Chapître, Rue du Chapitre, 23200 Aubusson, France",
                "place_id": "517182..."
            }
        },
        ...,
        ...,
    ]
}
```

Notes: 
1. You will need to use the RESTful Countries API to identify the lat and long of the capital city for the provided country.
2. For testing purposes, the following countries can be used for 'Happy Path' testing: New Zealand, Latvia, France
3. For testing purposes, the following countries can be used for 'Sad Path' testing: Ecuador, Uruguay