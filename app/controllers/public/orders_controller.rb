class Public::OrdersController < ApplicationController

  before_action :authenticate_customer!

  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save!
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price
        order_detail.save!
      end
      @cart_items.destroy_all
      redirect_to public_thanks_path
    else
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  def confirm
    @cart_items = current_customer.cart_items
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 500
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
      @address = current_customer.addresses.new
      @address.postal_code = params[:order][:postal_code]
      @address.address = params[:order][:address]
      @address.name = params[:order][:name]
      @order.customer_id = current_customer.id
      if @address.save
        @order.postal_code = @address.postal_code
        @order.address = @address.address
        @order.name = @address.name
      else
        render :new
      end
    end
    # binding.pry
    @cart_items = current_customer.cart_items.all
    @order.total_payment = @cart_items.inject(0) {|sum, item| sum + item.subtotal }
  end

  def thanks
  end

  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code,:address,:name,:shipping_cost,:total_payment)
  end

end
