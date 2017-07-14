class Plugins::Diehard_FundWebhooks::Slack::NewCommentSerializer < Plugins::Diehard_FundWebhooks::Slack::BaseSerializer

  def attachment_fallback
    object.body
  end

  def attachment_text
    object.body
  end

  private

  def text_options
    {
      author:   slack_link_for(object.author),
      name:     slack_link_for(object.discussion)
    }
  end

end
