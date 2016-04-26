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

  def attachment_fields
    Array(view_it_on_loomio)
  end

  private

  def text_options
    { author: object.author.name, name: slack_link_for(object) }
  end

end
