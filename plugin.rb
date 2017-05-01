module Plugins
  module LoomioWebhooks
    class Plugin < Plugins::Base

      setup! :loomio_webhooks do |plugin|
        plugin.enabled = true

        plugin.use_class "app/models/webhook"
        plugin.use_class "app/services/webhook_service"
        plugin.use_class "app/serializers/slack/base_serializer"
        plugin.use_class_directory "app/serializers/slack/"
        plugin.use_class "app/admin/webhooks"

        plugin.use_database_table :webhooks do |table|
          table.references :hookable, polymorphic: true, index: true
          table.string :kind, null: false
          table.string :uri, null: false
          table.text   :event_types, array: true, default: []
          table.timestamps
        end

        plugin.extend_class(Group)   { has_many :webhooks, as: :hookable }
        plugin.extend_class(Motion)  { delegate :webhooks, to: :discussion }
        plugin.extend_class(Comment) { delegate :webhooks, to: :discussion }
        plugin.extend_class(Vote)    { delegate :webhooks, to: :discussion }
        plugin.extend_class(Poll)    { delegate :webhooks, to: :discussion, allow_nil: true }
        plugin.extend_class(Outcome) { delegate :webhooks, to: :discussion }
        plugin.extend_class(Discussion) do
          def webhooks
            Webhook.where("(hookable_type = 'Discussion' AND hookable_id = :id) OR
                           (hookable_type = 'Group'      AND hookable_id = :group_id)",
                           id: id, group_id: group_id)
          end
        end

        plugin.use_events do |event_bus|
          event_bus.listen('motion_outcome_created_event',
                           'motion_outcome_updated_event',
                           'motion_closing_soon_event',
                           'motion_closed_by_user_event',
                           'motion_closed_event',
                           'new_discussion_event',
                           'new_comment_event',
                           'new_motion_event',
                           'new_vote_event',
                           'poll_created_event',
                           'poll_closing_soon_event',
                           'poll_expired_event',
                           'outcome_created_event') { |event| WebhookService.delay.publish!(event) }
        end
      end
    end
  end
end
