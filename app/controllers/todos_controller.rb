class TodosController < ApplicationController
  before_action :set_topic
  before_action :set_column
  before_action :set_todo, only: [:edit, :update, :destroy]

  def create
    @todo = Todo.new(todo_params)
    @todo.column = @column
    @todo.topic = @topic
    @todo.user = current_user
    authorize @todo
    if @todo.save
      redirect_to @topic
    else
      render :new
    end
  end

  def new
    @todo = @column.todos.new
    authorize @todo
  end

  def destroy
    authorize @todo
    @todo.destroy
    redirect_to @topic
  end

  def update
    authorize @todo
    params[:positions].uniq.each_with_index do |id, index|
      @topic.todos.find(id).update(position: index + 1)
    end
    if @todo.update(todo_params)
      respond_to do |format|
        format.html { redirect_to @topic, notice: 'Todo was successfully updated.' }
        format.json {}
      end
    else
      render :edit
    end
  end

  private

  def set_topic
    @topic = current_user.topics.includes(columns: :todos).find(params[:topic_id])
  end

  def set_column
    @column = @topic.columns.find(params[:column_id])
  end

  def set_todo
    @todo = @topic.todos.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:column_id, :content, :user_id)
  end
end
