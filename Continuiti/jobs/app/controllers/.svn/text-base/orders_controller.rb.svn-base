class OrdersController < BaseController
  # GET /orders/new
  # GET /orders/new.xml
  def new
    @order = Order.new(:express_token => params[:token])

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @order }
    end
  end


  # POST /orders
  # POST /orders.xml
  def create
    @order = current_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      if @order.purchase
        #transaction was successfull. Now we can update our required database table
        @order.cart.cart_items.each do |cart_item|
          job = Job.find(cart_item.job_id)
          job.update_attributes(:total_paid_amount => cart_item.unit_price * cart_item.quantity, :status => 1)
        end
        flash[:notice] = "Transaction was successfull."
        redirect_to user_jobs_list_by_status_url(current_user.id,"open")
      else
        flash[:notice] = "#{@order.transactions.last.message}. Please check your credit card or paypal account and insert your information carefully. You can contact us at anytime for support."
        render :action => 'new'
        #        render :text => "#{@order.transactions.last.message}"
      end
    else
      render :action => 'new'
    end
  end

  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => temporary_jobs_jobs_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
end
