class Plugins::DiehardFundWebhooks::Slack::NewDiscussionSerializer < Plugins::DiehardFundWebhooks::Slack::BaseSerializer

  def attachment_title
    slack_link_for(object)
  end

  def attachment_text
    "#{object.description}\n"
  end

  def attachment_color
    SiteSettings.colors[:primary]
  end

  private

  def text_options
    {
      author: slack_link_for(object.author),
      name:   slack_link_for(object),
      group:  slack_link_for(object.group)
    }
  end

end
