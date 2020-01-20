require 'rails_helper'

RSpec.describe AccountHoldersController, :type => :controller do
  before { configure_api_headers }

  describe "#create" do
    let(:params) do
      { name: "João Mello" }
    end

    it "creates an account holder" do
      post :create, params: params
      expect(assigns(:account_holder)).to be_persisted
    end

    it "creates an account from the account_holder" do
      post :create, params: params
      expect(assigns(:account)).to be_persisted
      expect(assigns(:account).account_holder).to eql(assigns(:account_holder))
    end

    it "brings code 201 created" do
      post :create, params: params
      expect(response.code).to eq('201')
    end

    it "responds the created account_holder" do
      post :create, params: params
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["name"]).to eql("João Mello")
      expect(parsed_response["token"]).to be_present
    end

    context "when params are invalid" do
      let(:params) do
        { name: "" }
      end

      it "does not create an account_holder" do
        post :create, params: params
        expect(assigns(:account_holder)).not_to be_persisted
      end

      it "brings code 422 created" do
        post :create, params: params
        expect(response.code).to eq('422')
      end

      it "responds the errors" do
        post :create, params: params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response["name"]).to include("can't be blank")
      end
    end
  end
end
