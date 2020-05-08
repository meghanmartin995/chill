class ResourcesController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @resource = Resource.new(resource_params)
    @resource.user = current_user
    authorize @resource
    @resource.topic = @topic
    if @resource.save
      redirect_to topic_path(@topic)
    else
      render 'topics/show'
    end
  end

  def destroy
    @resource = Resource.find(params[:id])
    authorize @resource
    @resource.destroy
    @topic = @resource.topic
    redirect_to topic_path(@topic)
  end

  private

  def resource_params
    params.require(:resource).permit(:title, :topic_id)
  end
end
