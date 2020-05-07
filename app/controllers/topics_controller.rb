class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def show
    @topics = Topic.find(params[:id])
    @resource = Resource.new
  end
end
