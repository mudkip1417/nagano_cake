class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.item.price
        order_detail.save
      end
      redirect_to public_thanks_path
      cart_items.destroy.all
    else
      @order = Order.new(order_params)
      render :new
    end
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    elsif params[:order][:select_address] == "2"
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @order.shipping_cost = 1
      @order.total_payment = 1
      if @order.save
      else
        render :new
      end
    end
    # binding.pry
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.subtotal }
  end

  def thanks
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code,:address,:name)
  end

end
