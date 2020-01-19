FactoryBot.define do
  factory :bank_transfer do
    source_account_id { 1 }
    destination_account_id { 1 }
    amount { 1 }
  end
end
