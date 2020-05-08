class TopicsController < ApplicationController
  def index
    @topics = policy_scope(Topic).order(created_at: :desc)
    @topic = Topic.new
  end

  def show
    @topic = Topic.find(params[:id])
    authorize @topic
    @resource = Resource.new
    @todo = Todo.new
    @topics = Topic.all
  end

  def create
    @topic = Topic.new(topic_params)
    @topic.user = current_user
    authorize @topic
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
