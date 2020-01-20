class BankTransfersController < ApplicationController
  def create
    @bank_transfer = BankTransfer.new(bank_transfer_params.merge(current_holder: current_holder))

    if @bank_transfer.save
      render json: @bank_transfer, status: :created
    else
      render json: @bank_transfer.errors, status: :unprocessable_entity
    end
  end

  private

  def bank_transfer_params
    params.permit(%w[source_account_id destination_account_id amount])
  end
end
