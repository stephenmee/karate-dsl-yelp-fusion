@business
Feature: Provide autocomplete suggestions for businesses, search keywords and categories.
  for reference, see: https://www.yelp.com/developers/documentation/v3/get_started

  Background:
    * url 'https://'+host+'/v3/autocomplete'
    * header Authorization = 'Bearer '+apiKey

  Scenario: verify 200 status code response
    Given param text = 'del'
    And param latitude = '37.786942'
    And param longitude = '122.399643'
    When method get
    Then status 200

  Scenario: verify categories, businesses and terms array in response
    Given param text = 'del'
    And param latitude = '37.786942'
    And param longitude = '-122.399643'
    When method get
    Then match response ==
    """
     {
      "categories": '#array',
      "businesses": '#array',
      "terms": '#array'
    }
    """
