class Plugins::Diehard_FundWebhooks::Slack::MotionClosingSoonSerializer < Plugins::Diehard_FundWebhooks::Slack::BaseSerializer

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
      name:   slack_link_for(object.discussion)
    }
  end

end
