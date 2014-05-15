require 'test_helper'

class ActivitiesHelperTest < ActionView::TestCase
  include FlickrHelper

  test 'flickr image request' do
    response = FlickrHelper::search_images('kitten')
    assert response['stat'] == nil
  end
end
