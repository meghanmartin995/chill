class TodosController < ApplicationController
  before_action :set_topic, except: [ :edit, :update, :create, :destroy ]
  before_action :set_column, except: [ :edit, :update, :create, :destroy ]
  protect_from_forgery :only => [:destroy]
  #before_action :set_todo, only: [:destroy]

  def create
    #@todo = @column.todos.new(todo_params)
    @todo = Todo.new(todo_params)
    @topic = Topic.find(params[:topic_id])
    @column = @topic.columns.find(params[:column_id])
    @todo.column = @column
    @todo.topic = @topic
    @todo.user = current_user
    authorize @todo
    if @todo.save
      TopicChannel.broadcast_to(@topic, type: 'create',
                                        todo: TodosController.render(@todo, locals: { topic: @topic, column: @column }),
                                        column_id: @column.id)
      redirect_to @topic
    else
      redirect_to @topic
    end
  end

  def new
    @todo = @column.todos.new
    authorize @todo
  end

  def destroy
    @todo = Todo.find(params[:id])
    authorize @todo
    @topic = Topic.find(params[:topic_id])
    #@column = @topic.columns.find(params[:column_id])
    if @todo.destroy
      TopicChannel.broadcast_to(@topic, type: "destroy", todo_id: @todo.id)
    end
    redirect_to @topic
  end

  def edit
    @todo = Todo.find(params[:id])
    @topic = @todo.topic
    authorize @todo
    # @todo.update(todo_params)
    # @todo.save
    # @todo.user = current_user
  end

  def update
    @todo = Todo.find(params[:id])
    authorize @todo
    @topic = Topic.find(params[:topic_id])
    @todo.topic = @topic
    @column = @todo.column
    if params[:positions]
      params[:positions].uniq.each_with_index do |id, index|
        @topic.todos.find(id).update(position: index + 1)
      end
    end

    if @todo.update(todo_params)
      TopicChannel.broadcast_to(@topic, type: "update",
                                        column_id: @column.id,
                                        column: TodosController.render(@column.todos.order(position: :asc),
                                          locals: { topic: @topic, column: @column }))

      new_column_todos = @topic.columns.find(params[:todo][:column_id]).todos.order(position: :asc)
      TopicChannel.broadcast_to(@topic, type: "update",
                                        column_id: params[:todo][:column_id],
                                        column: TodosController.render(new_column_todos,
                                           locals: { topic: @topic, column: @column }))
      respond_to do |format|
        format.html { redirect_to @topic, notice: 'Todo was successfully updated.' }
        format.json {}
      end
    else
      raise
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
    params.require(:todo).permit(:column_id, :title, :color, :description, :user_id)
  end
end
