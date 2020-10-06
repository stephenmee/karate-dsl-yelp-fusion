@business
Feature: This endpoint returns a list of businesses based on the provided phone number. It is possible for more than
  one business to have the same phone number (for example, chain stores with the same +1 800 phone number).
  Note: at this time, the API does not return businesses without any reviews.

  Background:
    * url 'https://'+host+'/v3/businesses/search/phone'
    * header Authorization = 'Bearer '+apiKey

  Scenario: verify 200 status code response
    Given param phone = '+14157492060'
    When method get
    Then status 200
    Then match response ==
    """
    {"businesses": [{"id": "WavvLdfdP6g8aZTtbBQHTw", "alias": "gary-danko-san-francisco", "name": "Gary Danko", "image_url": "https://s3-media0.fl.yelpcdn.com/bphoto/CAprIoeKQAYV9oUw9xBbmA/o.jpg", "is_closed": false, "url": "https://www.yelp.com/biz/gary-danko-san-francisco?adjust_creative=6AbCaexLqwnJsHqFj_HZBQ&utm_campaign=yelp_api_v3&utm_medium=api_v3_phone_search&utm_source=6AbCaexLqwnJsHqFj_HZBQ", "review_count": 5522, "categories": [{"alias": "newamerican", "title": "American (New)"}, {"alias": "french", "title": "French"}, {"alias": "wine_bars", "title": "Wine Bars"}], "rating": 4.5, "coordinates": {"latitude": 37.80587, "longitude": -122.42058}, "transactions": [], "price": "$$$$", "location": {"address1": "800 N Point St", "address2": "", "address3": "", "city": "San Francisco", "zip_code": "94109", "country": "US", "state": "CA", "display_address": ["800 N Point St", "San Francisco, CA 94109"]}, "phone": "+14157492060", "display_phone": "(415) 749-2060"}], "total": 1}
    """




