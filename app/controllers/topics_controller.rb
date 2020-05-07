class TopicsController < ApplicationController
  def index
    @topics = Topic.all
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    @resource = Resource.new
    @todo = Todo.new
  end

  def create
    @topic = Topic.new(topic_params)
    if @topic.save
      redirect_to topics_path
    else
      render 'topics/index'
    end
  end

  private

  def topic_params
    params.require(:topic).permit(:title, :color)
  end
end
