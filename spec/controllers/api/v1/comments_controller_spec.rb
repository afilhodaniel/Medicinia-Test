require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  before {
    @current_user = FactoryGirl.create(:user)
    session[:current_user_id] = @current_user.id
  }

  describe "#index" do
    context "when the request is made in json format" do
      let(:comments) { create_list(:comment, 10) }
      
      before { get :index, format: :json }

      it "gets an array of comments" do
        expect(assigns(:comments)).to match_array(comments)
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
    let(:comment) { FactoryGirl.create(:comment) }

    context "when the request has valid fields" do
      before { get :show, id: comment.id, format: :json }

      it "gets a comment object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:comment)).to eq(comment)
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
          get :show, id: comment.id
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#create" do
    context "when the request has valid fields" do
      before { post :create, comment: FactoryGirl.attributes_for(:comment), format: :json }
      
      it "gets a valid comment object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:comment)).to be_truthy
      end

      it "return the :success template" do
        expect(response).to render_template :success
      end
    end

    context "when de request has invalid fields" do
      before { post :create, comment: FactoryGirl.attributes_for(:comment, comment: nil), format: :json }

      it "gets an invalid comment object" do
        expect(assigns(:errors)).to be_truthy
        expect(assigns(:comment)).to be_truthy
      end

      it "return the :error template" do
        expect(response).to render_template :error
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format error" do
        expect {
          post :create, comment: FactoryGirl.attributes_for(:comment)
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#update" do
    let(:comment) { FactoryGirl.create(:comment) }

    context "when the request has valid fields" do
      before { put :update, id: comment.id, comment: FactoryGirl.attributes_for(:comment, comment: Faker::Lorem.sentence), format: :json }

      it "gets a valid comment object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:comment)).to be_truthy
      end

      it "render the :success template" do
        expect(response).to render_template :success
      end
    end

    context "when the request has invalid fields" do
      before { put :update, id: comment.id, comment: FactoryGirl.attributes_for(:comment, comment: nil), format: :json }

      it "gets a invalid comment object" do
        expect(assigns(:errors)).to be_truthy
        expect(assigns(:comment)).to be_truthy
      end

      it "return the :error template" do
        expect(response).to render_template :error
      end
    end

    context "when the request is made in other format than json" do
      it "raise unknown format error" do
        expect {
          put :update, id: comment.id, comment: FactoryGirl.attributes_for(:comment)
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

  describe "#delete" do
    let(:comment) { FactoryGirl.create(:comment) }

    context "when the request has valid fields" do
      before { delete :destroy, id: comment.id, format: :json }

      it "gets a valid comment object" do
        expect(assigns(:errors)).to be_falsy
        expect(assigns(:comment)).to be_truthy
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
          delete :destroy, id: comment.id
        }.to raise_error ActionController::UnknownFormat
      end
    end
  end

end