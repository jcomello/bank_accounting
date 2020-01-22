class AccountHoldersController < ApplicationController
  skip_before_action :authenticate

  def create
    @account_holder = AccountHolder.new(account_holder_params)

    if @account_holder.save
      @account = @account_holder.accounts.create(initial_amount: 10000)
      render json: @account_holder, status: :created
    else
      render json: @account_holder.errors, status: :unprocessable_entity
    end
  end

  private

  def account_holder_params
    params.permit(:name)
  end
end
