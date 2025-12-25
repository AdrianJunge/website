class PostsController < ApplicationController
  def timeline
    @timeline = get_timeline
  end
end
