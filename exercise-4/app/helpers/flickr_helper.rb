require 'rubygems'
require 'json'
require 'open-uri'

module FlickrHelper

  private
    API_KEY = 'aa8742cb9ef08ae46da6e72f78fa6c30'
    API_SECRET = '32f0a1438f1e68d4'
    FLICKR_API_URL = 'https://api.flickr.com/services/rest/?'
    FLICKR_SEARCH_METHOD = 'flickr.photos.search'

  public
    # Twitter image url format
    # http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
    # or
    #     http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}_[mstzb].jpg
    # or
    #     http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{o-secret}_o.(jpg|gif|png)
    def self.search_images(text)
      #ToDo escape text
      params = { method: FLICKR_SEARCH_METHOD ,
                 api_key: API_KEY,
                 format: 'json',
                 nojsoncallback: 1,
                 text: text }
      request_url = FLICKR_API_URL + params.to_query
      images = open(request_url)
      response = images.read
      image_content = JSON.parse(response)
      return image_content
    end

end