class AccountHolder < ApplicationRecord
  has_many :accounts

  validates :name, :token, presence: true

  def initialize(attributes)
    super(attributes)
    self.token ||= SecureRandom.hex
  end
end
