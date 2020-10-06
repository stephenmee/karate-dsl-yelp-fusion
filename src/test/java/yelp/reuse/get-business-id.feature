@ignore
Feature: the name is expected to be set as a call arg

  Background:
    * url "https://"+host+"/v3/businesses/search"
    * header Authorization = 'Bearer '+apiKey

  Scenario:
    * print name
    Given param term = term
#    New York City
    And param latitude = latitude
    And param longitude = longitude
    When method get
    Then status 200
