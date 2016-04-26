class Plugins::LoomioWebhooks::Slack::NewMotionSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def text_options
    { name: slack_link_for(object.discussion) }
  end

  def attachment_fallback
    "*#{object.name}*\n#{object.description}\n"
  end

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    "#{object.description}\n"
  end

  def attachment_fields
    Array(motion_vote_field)
  end

end
