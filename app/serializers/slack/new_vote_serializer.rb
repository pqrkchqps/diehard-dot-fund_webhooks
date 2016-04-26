class Plugins::LoomioWebhooks::Slack::NewVoteSerializer < Plugins::LoomioWebhooks::Slack::BaseSerializer

  def text_options
    {
      position: I18n.t(:"webhooks.slack.position_verbs.#{object.position}"),
      proposal: slack_link_for(object.motion),
      name:     slack_link_for(object.discussion)
    }
  end

  def attachment_fallback
    "*#{object.position}*\n#{object.statement}\n"
  end

  def attachment_text
    "#{object.statement}\n"
  end

  def attachment_color
    case object.position
    when "yes"     then SiteSettings.colors[:agree]
    when "no"      then SiteSettings.colors[:disagree]
    when "abstain" then SiteSettings.colors[:abstain]
    when "block"   then SiteSettings.colors[:block]
    end
  end
end
