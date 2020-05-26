class TopicChannel < ApplicationCable::Channel
  def subscribed
    topic = Topic.find(params[:topic_id])
    stream_for topic
  end

  def unsubscribed
    Rails.logger.info "Disconnected from server"
  end
end
