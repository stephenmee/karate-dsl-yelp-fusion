@business
Feature: This endpoint returns up to 1000 businesses based on the provided search criteria.
  It has some basic information about the business. To get detailed information and reviews, please use the
  Business ID returned here and refer to /businesses/{id} and /businesses/{id}/reviews endpoints.
  Note: at this time, the API does not return businesses without any reviews.
  For reference, see: https://www.yelp.com/developers/documentation/v3/get_started

  Background:
    * url 'https://'+host+'/v3/businesses/search'
    * header Authorization = 'Bearer '+apiKey

  Scenario: verify 200 status code response
    Given param term = 'del'
    And param latitude = '37.786942'
    And param longitude = '122.399643'
    When method get
    Then status 200

  Scenario: print business id
    * def result = call read('classpath:yelp/reuse/get-business-id.feature') {term: 'italian', latitude: 40.730610, longitude: -73.935242}
    * def response = result.response
    * print response.businesses
    * def firstItem = get[0] response.businesses
    * def id = firstItem.id
    * print id
#    * def firstItem = get[0] response.businesses
#    * def id = firstItem.id
#    * print id
#    And def firstToken = response.response.data.posts.lastToken
#    And def result = call read('classpath:feeds/reuse/get-last-token-pass-token.feature') {lastToken: '#(firstToken)'}
#    Then match result.response.data.posts.lastToken != firstToken
#    * print result
#    * def result = call read('called-normal.feature') { name: 'Nyan', age: 10 }
##    New York City
#    And param latitude = '40.730610'
#    And param longitude = '-73.935242'
#    When method get
#    * def firstItem = get[0] response.businesses
#    * def id = firstItem.id
#    * print id
#    Then status 200

  Scenario Outline: verify businesses array, total number, longitude/latitude in response
    Given param term = '<term>'
    And param latitude = <latitude>
    And param longitude = <longitude>
    When method get
    Then match response ==
    """
     {
      "businesses": '#array',
      "total": '#number',
       "region": {
        "center": {
            "longitude": <longitude>,
            "latitude": <latitude>
        }
    }
    }
    """
    Examples:
      | term    | latitude  | longitude | location |
      | del     | 53.350140 | -6.266155 | Dublin   |
      | chinese | 51.903614 | -8.468399 | Cork     |


