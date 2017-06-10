class Plugins::LoomioWebhooks::WebhookService

  def self.publish!(event)
    Array(event.eventable&.webhooks).each do |webhook|
      next unless webhook.event_types.include? event.kind
      HTTParty.post webhook.uri, body: payload_for(webhook, event), headers: webhook.headers
    end
  end

  def self.payload_for(webhook, event)
    serializer_for(webhook, event).new(event.eventable, root: false).to_json
  end
  private_class_method :payload_for

  def self.serializer_for(webhook, event)
    [:Plugins, :LoomioWebhooks, webhook.kind.classify, "#{event.kind.classify}Serializer"].join('::').constantize
  end
  private_class_method :serializer_for

end
