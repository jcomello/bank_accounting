FactoryBot.define do
  factory :account do
    account_holder_id { FactoryBot.create(:account_holder).id }
  end
end
