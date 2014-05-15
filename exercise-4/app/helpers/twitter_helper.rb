require 'rubygems'
require 'oauth'
require 'json'

module TwitterHelper

  private
    API_BASE_URL = 'https://api.twitter.com'
    TWEET_PATH = '/1.1/statuses/update.json'
    CONSUMER_KEY = 'j6dl5jJylpWZGoYNBLxnyUpmj'
    CONSUMER_SECRET = 'boYAWmA6NmDP6FdDSaPR7dGt6HRK8IVNpFBhnwuMVxOwyYMQ5A'
    ACCESS_TOKEN = '2492850913-JRFJ1rSMrQiyiPk3N8XUfOQ57W0vKAj0oKjk4dj'
    ACCESS_SECRET = 'VFF8sod9a1ukKXCIK9EeOVB2gtbMRMDhzJ1iMlXNIcFbQ'
    HASH_TAG = ' #webengeth4'

  public
    def self.post_tweet(text)

      if text.nil? or text.equal? ''
        return FALSE
      end

      unless text.downcase.include? HASH_TAG
        text.concat(HASH_TAG)
      end

      consumer_key = OAuth::Consumer.new(CONSUMER_KEY, CONSUMER_SECRET)
      access_token = OAuth::Token.new(ACCESS_TOKEN, ACCESS_SECRET)

      address = URI("#{API_BASE_URL}#{TWEET_PATH}")
      request = Net::HTTP::Post.new address.request_uri
      request.set_form_data(
          'status' => text,
      )

      # Set up HTTP.
      http             = Net::HTTP.new(address.host, address.port)
      http.use_ssl     = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      # Issue the request.
      request.oauth!(http, consumer_key, access_token)
      http.start
      response = http.request(request)

      status = (response.code == '200') ? true : false
      return status
    end
end
