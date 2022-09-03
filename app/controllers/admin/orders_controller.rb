class Admin::OrdersController < ApplicationController

  before_action :authenticate_admin!


  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    @order_details = @order.order_details

    if @order.order_status == "入金確認"
      @order_details.each do |order_detail|
        order_detail.maiking_status = "製作待ち"
        order_detail.save
      end
    end
    redirect_to admin_order_path
  end

  private

  def order_params
    params.require(:order).permit(:order_status)
  end

end



#   def show

#   end

#   def update
#     @order = Order.find(params[:id])
#     @order.update(order_params)
#     redirect_to order_path(@order.id)
#   end

#   def order_params
#     params.require(:order).permit(:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method,:order_status)
#   end

# end
