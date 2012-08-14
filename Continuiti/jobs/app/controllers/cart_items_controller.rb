class CartItemsController < BaseController
  def create
    @job = Job.find(params[:job_id])
    @cart = current_cart
    @cart_item = set_cart_item(@cart, @job)
    #    @cart_item = CartItem.create!(:cart_id => @cart.id, :job_id => @job.id, :quantity => 1, :unit_price => @job.total_cost_calculated.to_f)
    flash[:notice] = "Added #{@job.title} to cart."
    respond_to do |format|
      format.html{ redirect_to cart_path}
      format.js do
        render :update do |page|
          page.replace_html "cart_items", :partial => '/jobs/cart_items'
        end
      end
    end
  end
end
