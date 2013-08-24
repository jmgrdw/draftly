class AccountsController < ApplicationController
  
  before_filter :authenticate_user!
  
  def show
    @user = current_user
    @account = @user.account
    # @account_transactions = @account.products
    @transaction_history = @account.transaction_histories
  end
  
  def add_funds
    @user = current_user
    @account = @user.account
    @products = Product.ascending
  end


end