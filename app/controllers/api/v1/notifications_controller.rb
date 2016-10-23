module Api
  module V1
    class NotificationsController < BaseController
      after_action :send_notification, only: [:create]
      before_action :verify_authority, only: [:index, :show, :update, :destroy, :search]

      def search
        @notifications = Notification.where('note LIKE ? AND user_id = ?', "%#{query_params[:note]}%", query_params[:user_id]).page(page_params[:page]).per(page_params[:page_size])

        respond_to do |format|
          format.json { render :index }
        end
      end
      
      private

        def send_notification
          if @notification.valid?
            pusher = Pusher::Client.new(app_id: ENV["PUSHER_APP_ID"], key: ENV["PUSHER_KEY"], secret: ENV["PUSHER_SECRET"])

            pusher.trigger('notification_channel', 'new_notification', @notification.to_json)
          end
        end

        def verify_authority
          if query_params[:user_id].blank?
            respond_to do |format|
              format.json { render :unpermitted }
            end
          end

          if query_params[:user_id] and query_params[:user_id].to_i != @current_user.id
            respond_to do |format|
              format.json { render :unpermitted }
            end
          end
        end
        
        def notification_params
          params.require(:notification).permit(:category, :note, :confirmed, :user_id)
        end
        
        def query_params
          params.permit(:id, :user_id, :category, :note)
        end
    end
  end
end