class Plugins::LoomioWebhooks::Slack::MotionOutcomeCreatedSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def attachment_fallback
    "*#{object.name}*\n#{object.outcome}\n"
  end

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    object.outcome
  end

  private

  def text_options
    {
      author: slack_link_for(object.outcome_author),
      name:   slack_link_for(object)
    }
  end

end
