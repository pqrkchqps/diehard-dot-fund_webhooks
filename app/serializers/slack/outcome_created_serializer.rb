class Plugins::Diehard_FundWebhooks::Slack::OutcomeCreatedSerializer < Plugins::Diehard_FundWebhooks::Slack::BaseSerializer

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
