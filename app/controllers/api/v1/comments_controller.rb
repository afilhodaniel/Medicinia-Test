module Api
  module V1
    class CommentsController < BaseController
      after_action :send_notification, only: [:create]

      private
        def send_notification
          if @comment.valid?
            pusher = Pusher::Client.new(app_id: ENV["PUSHER_APP_ID"], key: ENV["PUSHER_KEY"], secret: ENV["PUSHER_SECRET"])

            pusher.trigger('comment_channel', 'new_comment', @comment.to_json)
          end
        end

        def comment_params
          params.require(:comment).permit(:comment, :notification_id, :user_id)
        end
        
        def query_params
          params.permit(:id, :notification_id)
        end
    end
  end
end