class CartsController < BaseController
  def show
    @cart = current_cart
  end

  def destroy    
    current_cart.destroy
    session[:cart_id] = nil
    respond_to do |format|
      format.html{redirect_to user_jobs_list_by_status_url(current_user.id,"open")}
    end
  end
end
