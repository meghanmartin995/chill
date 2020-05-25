class CollaboratorsController < ApplicationController
  before_action :authenticate_user!
  before_action :skip_authorization

  def create
    user = User.find_by(email: params[:email])
    if user
      user_topic = UserTopic.create(user_id: user.id, topic_id: params[:topic_id])
      # UserMailer.with(user_topic: user_topic).invite_to_collaborate.deliver_later
      # redirect_back fallback_location: root_path, notice: "Invite sent"
      redirect_back fallback_location: root_path,
                    # notice: topic_collaborators_url(params[:topic_id], token: user_topic.token)
                    notice: "Collaborator has been added"
    else
      redirect_back fallback_location: root_path, notice: "User does not have account"
    end
  end

  def show
    user_topic = current_user.user_topics.includes(:topic).find_by(token: params[:token])
    if user_topic&.update(accepted: true)
      redirect_to user_topic.topic, notice: "Welcome to the topic"
    else
      redirect_to root_path, notice: 'Something went wrong'
    end
  end

  def destroy
    user_topic = current_user.user_topics.find_by(topic_id: params[:topic_id])
    user_topic.destroy
    redirect_to root_path, notice: 'You have left the topic'
  end
end
