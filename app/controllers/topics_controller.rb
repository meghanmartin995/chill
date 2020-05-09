class TopicsController < ApplicationController
  before_action :set_topic, only: [ :show ]
  def index
    @topics = policy_scope(Topic).order(created_at: :desc).where(user: current_user)
    @topic = Topic.new
  end

  def show
    # @topic = Topic.find(params[:id])
    #@topic = current_user.topics.find(params[:id])
    authorize @topic
    # @resource = Resource.new
    # @todo = Todo.new
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

  def set_topic
    @topic = current_user.topics
             .includes(columns: :todos)
             .order('columns.id, todos.position ASC')
             .find(params[:id])
  end
end
