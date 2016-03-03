class Plugins::LoomioWebhooks::Slack::MotionClosingSoon < Plugins::LoomioWebhooks::Slack::Base

  def text
    I18n.t :"webhooks.slack.motion_closing_soon", author: author.name, name: discussion_link
  end

  def attachment_fallback
    "*#{eventable.name}*\n#{eventable.description}\n"
  end

  def attachment_title
    proposal_link(eventable)
  end

  def attachment_text
    eventable.description
  end

  def attachment_fields
    [motion_vote_field]
  end

end
