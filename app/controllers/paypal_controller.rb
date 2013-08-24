class PaypalController < ApplicationController
  before_filter :assigns_gateway
    
  before_filter :find_product_by_id, :only => [:checkout]
  
  # before_filter :get_product_from_session, :only => [:review, :purchase]

    include ActiveMerchant::Billing
    include PaypalHelper

    def checkout
      @user = current_user
      @account = @user.account
      @account.products << @product
            
      total_as_cents, setup_purchase_params = get_setup_purchase_params @product, request  
      setup_response = @gateway.setup_purchase(total_as_cents, setup_purchase_params)
      session[:product_id] = @product.id
      redirect_to @gateway.redirect_url_for(setup_response.token)
    end
    
    def review
      @user = current_user
      @account = @user.account
      @product = Product.find(session[:product_id])
      
      if params[:token].nil?
        redirect_to root_path, :notice => "Something went wrong"
        return
      end
      
      gateway_response = @gateway.details_for(params[:token])
      
      unless gateway_response.success?
        redirect_to root_path, :notice => "Sorry! Something went wrong with the Paypal purchase. Here's what Paypal said: #{gateway_response.message}"
        return
      end
      
      @order_info = get_order_info gateway_response, @product
    end
    
    def purchase
      @user = current_user
      @account = @user.account
      @product = Product.find(session[:product_id])
      
      if params[:token].nil? or params[:payer_id].nil?
        session[:product_id] = nil
        redirect_to root_path, :notice => "Sorry! Something went wrong with the Paypal purchase. Please try again later."
        return
      end
      
      total_as_cents, purchase_params = get_purchase_params @product, request, params
      purchase = @gateway.purchase total_as_cents, purchase_params
      
      if purchase.success?
        @account.add_funds_and_record_transaction(@product.amount)
        # now we have to add it to their balance.
        notice = "Thanks! Your purchase is now complete."
      else
        notice = "Woops. Something went wrong while we were trying to complete the purchase with Paypal. Btw, here's what Paypal said: #{purchase.message}"
      end
      
      session[:product_id] = nil
      redirect_to root_path, :notice => notice
    end

    private
      def assigns_gateway
        @gateway ||= PaypalExpressGateway.new(
          :login => PaypalLogin.login,
          :password => PaypalLogin.password,
          :signature => PaypalLogin.signature,
        )
      end
      
      def find_product_by_id
        @product = Product.find(params[:product_id])
      end
  
end