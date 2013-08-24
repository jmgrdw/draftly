module PaypalHelper
  
  def get_setup_purchase_params(product, request)
    total = product.amount
    return to_cents(total), {
      :ip => request.remote_ip,
      :return_url => url_for(:action => 'review', :only_path => false),
      :cancel_return_url => "http://localhost:3000/home",
      :items => get_product(product)
    }
  end
  
  def get_product(product)
    [{
      :name => product.title,
      :amount => to_cents(product.amount)
    }]
  end
  
  def to_cents(money)
    (money*100).round
  end
  
  def get_order_info(gateway_response, product)
    {
      total: product.amount,
      email: gateway_response.email,
      name: gateway_response.name,
      gateway_details: {
        :token => gateway_response.token,
        :payer_id => gateway_response.payer_id,
      }
    }
  end
  
  def get_purchase_params(product, request, params)
    total = product.amount
      return to_cents(total), {
        :ip => request.remote_ip,
        :token => params[:token],
        :payer_id => params[:payer_id]
      }
    end
  
  
end