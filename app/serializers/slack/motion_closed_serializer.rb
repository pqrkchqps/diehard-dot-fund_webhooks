class Plugins::LoomioWebhooks::Slack::MotionClosedSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def attachment_fallback
    "*#{object.name}*\n#{object.description}\n"
  end

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    object.description
  end

  private

  def text_options
    {
      author: slack_link_for(object.author),
      name:   slack_link_for(object)
    }
  end

end
