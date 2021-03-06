class AccountsController < ApplicationController
  def show
    @account = current_holder.accounts.find_by(id: params["account_id"])
    if @account.present?
      render json: @account, status: :ok
    else
      render status: :not_found
    end
  end
end
