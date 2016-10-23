class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :force_authentication, except: [:index]
  before_action :set_current_user

  def index
    render :index
  end

  def patients
    @sidebar = :patients

    render :patients
  end

  def notifications
    @sidebar = :notifications
    
    render :notifications
  end

  def messages
    @sidebar = :messages

    render :messages
  end

  def tasks
    @sidebar = :tasks
    
    render :tasks
  end

  private

    def force_authentication
      if !is_authenticated
        redirect_to sessions_unauthenticated_path
      end
    end

    def is_authenticated
      if session[:current_user_id]
        return true
      else
        return false
      end
    end

    def set_current_user
      if is_authenticated
        @current_user = User.where(id: session[:current_user_id]).first
      else
        @current_user = nil
      end
    end
end
