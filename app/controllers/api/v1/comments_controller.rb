module Api
  module V1
    class CommentsController < BaseController
      private
        
        def comment_params
          params.require(:comment).permit(:comment, :notification_id, :user_id)
        end
        
        def query_params
          params.permit(:id, :notification_id)
        end
    end
  end
end