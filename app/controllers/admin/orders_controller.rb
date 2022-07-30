class Admin::OrdersController < ApplicationController

  def show

  end

  def update
    @order = Order.find(params[:id])
    @order.update(order_params)
    redirect_to order_path(@order.id)
  end

  def order_params
    params.require(:order).permit(:postal_code,:address,:name,:shipping_cost,:total_payment,:payment_method,:order_status)
  end

end
