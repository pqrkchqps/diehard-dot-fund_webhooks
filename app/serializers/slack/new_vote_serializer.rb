class Plugins::Diehard_FundWebhooks::Slack::NewVoteSerializer < Plugins::Diehard_FundWebhooks::Slack::BaseSerializer

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

  def attachment_fields
  end

  private

  def text_options
    {
      author:   slack_link_for(object.author),
      proposal: slack_link_for(object.motion),
      name:     slack_link_for(object.discussion),
      position: I18n.t(:"webhooks.slack.position_verbs.#{object.position}")
    }
  end

end
