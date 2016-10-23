require 'rails_helper'

RSpec.describe Api::V1::NotificationsController, type: :controller do
  before {
    @current_user = FactoryGirl.create(:user)
    session[:current_user_id] = @current_user.id
  }

  describe "#index" do
    context "when the request is made in json format" do
      let(:notifications) { create_list(:notification, 10, user_id: @current_user.id) }
      
      before { get :index, user_id: @current_user.id, format: :json }

      it "gets an array of notifications" do
        expect(assigns(:notifications)).to match_array(notifications)
      end

      it "render the :index template" do
        expect(response).to render_template :index
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format error" do
        expect {
          get :index
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#show" do
    let(:notification) { FactoryGirl.create(:notification, user_id: @current_user.id) }

    context "when the request has valid fields" do
      before { get :show, id: notification.id, user_id: @current_user.id, format: :json }

      it "gets a notification object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:notification)).to eq(notification)
      end

      it "render the :show template" do
        expect(response).to render_template :show
      end
    end

    context "when the request has invalid fields" do
      it "raise record not found error" do
        expect {
          get :show, id: 0, format: :json
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when the request is made in other format other than json" do
      it "raise unknown format error" do
        expect {
          get :show, id: notification.id
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#create" do
    context "when the request has valid fields" do
      before { post :create, notification: FactoryGirl.attributes_for(:notification), format: :json }
      
      it "gets a valid notification object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:notification)).to be_truthy
      end

      it "return the :success template" do
        expect(response).to render_template :success
      end
    end

    context "when de request has invalid fields" do
      before { post :create, notification: FactoryGirl.attributes_for(:notification, category: nil), format: :json }

      it "gets an invalid notification object" do
        expect(assigns(:errors)).to be_truthy
        expect(assigns(:notification)).to be_truthy
      end

      it "return the :error template" do
        expect(response).to render_template :error
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format error" do
        expect {
          post :create, notification: FactoryGirl.attributes_for(:notification)
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#update" do
    let(:notification) { FactoryGirl.create(:notification, user_id: @current_user.id) }

    context "when the request has valid fields" do
      before { put :update, id: notification.id, user_id: @current_user.id, notification: FactoryGirl.attributes_for(:notification, category: Faker::Number.between(0, 2)), format: :json }

      it "gets a valid notification object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:notification)).to be_truthy
      end

      it "render the :success template" do
        expect(response).to render_template :success
      end
    end

    context "when the request has invalid fields" do
      before { put :update, id: notification.id, user_id: @current_user.id, notification: FactoryGirl.attributes_for(:notification, category: nil), format: :json }

      it "gets a invalid notification object" do
        expect(assigns(:errors)).to be_truthy
        expect(assigns(:notification)).to be_truthy
      end

      it "return the :error template" do
        expect(response).to render_template :error
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format error" do
        expect {
          put :update, id: notification.id, notification: FactoryGirl.attributes_for(:notification)
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#delete" do
    let(:notification) { FactoryGirl.create(:notification, user_id: @current_user.id) }

    context "when the request has valid fields" do
      before { delete :destroy, id: notification.id, user_id: @current_user.id, format: :json }

      it "gets a valid notification object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:notification)).to be_truthy
      end

      it "return the :success template" do
        expect(response).to render_template :success
      end
    end

    context "when the request has invalid fields" do
      it "raise record not found error" do
        expect {
          delete :destroy, id: 0, format: :json
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format errorr" do
        expect {
          delete :destroy, id: notification.id
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

end