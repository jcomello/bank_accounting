require 'rails_helper'

RSpec.describe BankTransfersController, :type => :controller do

  let!(:source_account) { FactoryBot.create(:account, initial_amount: 4500) }
  let!(:destination_account) { FactoryBot.create(:account, initial_amount: 3000) }

  describe "#create" do
    let(:params) do
      {
        source_account_id: source_account.id,
        destination_account_id: destination_account.id,
        amount: 3.00
      }
    end

    it "creates a bank transfer" do
      post :create, params: params
      expect(assigns(:bank_transfer)).to be_persisted
    end

    it "brings code 201 created" do
      post :create, params: params
      expect(response.code).to eq('201')
    end

    it "responds the created bank transfer" do
      post :create, params: params
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["source_account_id"]).to eql(source_account.id)
      expect(parsed_response["destination_account_id"]).to eql(destination_account.id)
      expect(parsed_response["amount"]).to eql(3.0)
    end

    context "when params are invalid" do
      let(:params) do
        {
          destination_account_id: destination_account.id,
          amount: 3.00
        }
      end

      it "does not create a bank transfer" do
        post :create, params: params
        expect(assigns(:bank_transfer)).not_to be_persisted
      end

      it "brings code 422 created" do
        post :create, params: params
        expect(response.code).to eq('422')
      end

      it "responds the created bank transfer" do
        post :create, params: params
        parsed_response = JSON.parse(response.body)

        expect(parsed_response["source_account_id"]).to include("can't be blank")
      end
    end
  end
end
