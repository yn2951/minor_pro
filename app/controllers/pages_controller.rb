class PagesController < ApplicationController
  def index
    @topics = Topic.all
  end
end
