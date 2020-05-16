class ColumnsController < ApplicationController
  before_action :set_topic
  before_action :set_column, only: [:edit, :update, :destroy]

  def new
    @column = @topic.columns.new
    authorize @column
  end

  def edit
  end

  def create
    @column = Column.new(column_params)
    @column.topic = @topic
    @column.user = current_user
    authorize @column
    if @column.save
      redirect_to @topic
    else
      render :new
    end
  end

  def update
    if @column.update(column_params)
      redirect_to @column
    else
      render :edit
    end
  end

  def destroy
    authorize @column
    @column.destroy
    redirect_to @topic
  end

  private

  def set_topic
    @topic = Topic.find(params[:topic_id])
  end

  def set_column
    @column = @topic.columns.find(params[:id])
  end

  def column_params
    params.require(:column).permit(:topic_id, :title, :user_id)
  end
end
