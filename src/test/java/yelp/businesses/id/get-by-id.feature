@business
Feature: This endpoint returns detailed business content. Normally, you would get the Business ID from
  /businesses/search, /businesses/search/phone, /transactions/{transaction_type}/search or /autocomplete. To retrieve
  review excerpts for a business, please refer to our Reviews endpoint (/businesses/{id}/reviews)
  Note: at this time, the API does not return businesses without any reviews.

  Background:
    * url 'https://'+host+'/v3/businesses'
    * header Authorization = 'Bearer '+apiKey

  Scenario: Get business by business id, verify response code
    * def result = call read('classpath:yelp/reuse/get-business-id.feature') {term: 'italian', latitude: 40.730610, longitude: -73.935242}
    * def response = result.response
    * def firstItem = get[0] response.businesses
    * def id = firstItem.id
    Given path id
    When method get
    Then status 200

  Scenario Outline: Get business by business id
    * def result = call read('classpath:yelp/reuse/get-business-id.feature') {term: '<term>', latitude: <latitude>, longitude: <longitude>}
    * def response = result.response
    * def firstItem = get[0] response.businesses
    * def id = firstItem.id
    Given path id
    When method get
    Then status 200
    Then match response ==
    """
     {
        "id": "#string",
        "alias": "#string",
        "name": "#string",
        "image_url": "#string",
        "is_claimed":  #  boolean,
        "is_closed":  #  boolean,
        "url": "#string",
        "phone": "#string",
        "display_phone": "#string",
        "review_count":  #  number,
        "categories":  #  array,
        "rating":  #  number,
        "location":  #  object,
        "coordinates":  #  object,
        "photos":  #  array,
        "price": "#string",
        "hours":  #  array,
        "transactions":  #  array
    }
    """
    Examples:
      | term       | latitude  | longitude  | location      |
      | mexican    | 40.730610 | -73.935242 | New York City |
      | steak      | 51.509865 | -0.118092  | London        |
      | vegetarian | 53.350140 | -6.266155  | Dublin        |
