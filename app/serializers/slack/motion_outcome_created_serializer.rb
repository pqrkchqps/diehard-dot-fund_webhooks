class Plugins::LoomioWebhooks::Slack::MotionOutcomeCreated < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def attachment_fallback
    "*#{eventable.name}*\n#{eventable.outcome}\n"
  end

  def attachment_title
    slack_link_for(object.motion)
  end

  def attachment_text
    object.outcome
  end

  def attachment_fields
    Array(view_it_on_loomio)
  end

  private

  def text_options
    { author: object.outcome_author.name, name: slack_link_for(object) }
  end

end
