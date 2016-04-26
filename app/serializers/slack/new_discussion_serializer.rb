class Plugins::LoomioWebhooks::Slack::NewDiscussionSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def attachment_title
    "<#{slack_link_for(object)}|#{object.title}>"
  end

  def attachment_text
    "#{object.description}\n"
  end

  def attachment_color
    SiteSettings.colors[:primary]
  end

  private

  def text_options
    { author: object.author.name, name: slack_link_for(object), group: slack_link_for(object.group) }
  end

end
