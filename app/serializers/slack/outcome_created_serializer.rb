class Plugins::DiehardFundWebhooks::Slack::OutcomeCreatedSerializer < Plugins::DiehardFundWebhooks::Slack::BaseSerializer

  def attachment_fallback
    "*#{object.poll.title}*\n#{object.statement}\n"
  end

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    object.statement
  end

  private

  def text_options
    {
      author: slack_link_for(object.author),
      name:   slack_link_for(object.poll)
    }
  end

end
