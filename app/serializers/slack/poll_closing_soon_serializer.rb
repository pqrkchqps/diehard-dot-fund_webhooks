class Plugins::LoomioWebhooks::Slack::PollClosingSoonSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def attachment_fallback
    "*#{object.title}*\n#{object.details}\n"
  end

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    object.details
  end

  private

  def text_options
    {
      name:   slack_link_for(object.discussion)
    }
  end

end
