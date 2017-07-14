class Plugins::DiehardFundWebhooks::Slack::NewCommentSerializer < Plugins::DiehardFundWebhooks::Slack::BaseSerializer

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
