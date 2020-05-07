class TodosController < ApplicationController
  def create
  @topic = Topic.find(params[:topic_id])
  @todo = Todo.new(todo_params)
  @todo.topic = @topic
  if @todo.save
    redirect_to topic_path(@topic)
  else
    render 'topics/show'
  end
end

private

def todo_params
  params.require(:todo).permit(:title, :topic_id)
end
end
