class TodosController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @todo = Todo.new(todo_params)
    @todo.user = current_user
    authorize @todo
    @todo.topic = @topic
    if @todo.save
      redirect_to topic_path(@topic)
    else
      render 'topics/show'
    end
  end

  def destroy
    @todo = Todo.find(params[:id])
    authorize @todo
    @todo.destroy
    @topic = @todo.topic
    redirect_to topic_path(@topic)
  end

  def update
    @todo = Todo.find(params[:id])
    authorize @todo
    @todo.update(todo_params)
    @topic = @todo.topic
    if @todo.save
      redirect_to topic_path(@topic)
    else
      render 'topics/show'
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :topic_id, :completed)
  end
end
