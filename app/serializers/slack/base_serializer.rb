module Plugins
  module Diehard_FundWebhooks
    module Slack
      class BaseSerializer < ActiveModel::Serializer
        include Routing
        attributes :text, :username, :attachments, :icon_url

        def text
          I18n.t :"webhooks.slack.#{event_kind}", text_options
        end

        def username
          "Diehard_Fund Bot"
        end

        def attachments
          [{
            title:       attachment_title,
            text:        attachment_text,
            fields:      attachment_fields,
            fallback:    attachment_fallback,
            color:       attachment_color
          }]
        end

        def icon_url
          # we'll host our own image soon I reckon
          "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-xap1/v/t1.0-1/p50x50/11537803_694991540606106_5116967442850884451_n.jpg?oh=eeba96f797e9cb12340bfd94df2650f0&oe=56802643&__gda__=1447229045_95708238caee2d950ea43c93b38b071c"
        end

        private

        def text_options;        end
        def attachment_title;    end
        def attachment_text;     end
        def attachment_fallback; end
        def attachment_color;    end
        def attachment_fields
          [view_it_on_diehard_fund]
        end

        def motion_vote_field
          {
            title: I18n.t(:"webhooks.slack.have_your_say"),
            value: [:yes, :abstain, :no, :block].map { |pos| slack_link_for(object, pos) }.join( ' . ')
          }
        end

        def view_it_on_diehard_fund(model = object, text = I18n.t(:"webhooks.slack.view_it_on_diehard_fund"))
          { value: slack_link_for(model, text) }
        end

        def slack_link_for(model, text = nil, params = {})
          params.merge!(default_url_options)
          case model
          when User       then "<#{user_url(model.username, params)}|#{text || model.name}>"
          when Group      then "<#{group_url(model, params)        }|#{text || model.name}>"
          when Discussion then "<#{discussion_url(model, params)   }|#{text || model.title}>"
          when Motion     then "<#{motion_url(model, params)       }|#{text || model.name}>"
          when Poll       then "<#{poll_url(model, params)         }|#{text || model.title}>"
          when Outcome    then "<#{poll_url(model.poll, params)    }|#{text || model.poll.title}>"
          when Comment    then "<#{discussion_url(model.discussion, params.merge(comment: model.id))}|#{text || model.body}>"
          end
        end

        def event_kind
          self.class.name.split('::').last.snakecase.gsub('_serializer', '')
        end

      end
    end
  end
end
