require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do
  let(:account_holder) { FactoryBot.create(:account_holder) }

  let!(:account) { FactoryBot.create(:account, account_holder: account_holder, initial_amount: 4500) }
  let!(:other_account) { FactoryBot.create(:account, account_holder: account_holder, initial_amount: 3000) }

  before { api_sign_in(account_holder) }

  describe "#show" do
    let(:params) do
      { account_id: account.id }
    end

    it "shows the correct account" do
      get :show, params: params
      expect(assigns(:account)).to eql(account)
    end

    it "brings code 200 ok" do
      get :show, params: params
      expect(response.code).to eq('200')
    end

    it "responds the account values" do
      get :show, params: params
      parsed_response = JSON.parse(response.body)

      expect(parsed_response["id"]).to eql(account.id)
      expect(parsed_response["balance"]).to eql(45.0)
    end

    context "when account requested does not exist" do
      let(:params) do
        { account_id: 99999 }
      end

      it "brings code 404 not found" do
        get :show, params: params
        expect(response.code).to eq('404')
      end
    end

    context "when account requested belongs to another account holder" do
      let!(:other_account_holder) { FactoryBot.create(:account_holder) }
      let(:params) do
        { account_id: account.id }
      end

      before { api_sign_in(other_account_holder) }

      it "brings code 404 not found" do
        get :show, params: params
        expect(response.code).to eq('404')
      end
    end
  end
end
