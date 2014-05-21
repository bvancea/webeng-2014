module ActivitiesHelper

  def activity_image_picker_path(activity)
    {
        controller: 'activities',
        action: 'show_image_picker',
        :activity => activity.id
    }
  end

  def activity_make_definitive_path(activity)
    {
        controller: 'activities',
        action: 'make_definitive',
        :activity => activity.id
    }
  end

  def vote_activity_path(activity)
    {
        controller: 'activities',
        action: 'vote',
        :activity => activity.id
    }
  end

  def show_activity_path(activity)
    {
        controller: 'activities',
        action: 'show',
        :activity => activity.id
    }
  end

  def edit_activity_path(activity)
    {
      controller: 'activities',
      action: 'edit',
      :id => activity.id
    }
  end

  def unvote_activity_path(activity)
    {
        controller: 'activities',
        action: 'unvote',
        :activity => activity.id
    }
  end

  def search_images_on_flickr
    {
        controller: 'activities',
        action: 'search_images_on_flickr'
    }
  end
end
