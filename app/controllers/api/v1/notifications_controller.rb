module Api
  module V1
    class NotificationsController < BaseController
      private
        
        def notification_params
          params.require(:notification).permit(:category, :note, :confirmed, :user_id)
        end
        
        def query_params
          params.permit(:id)
        end
    end
  end
end