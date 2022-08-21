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
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    if params[:address_id] == 0
      @order.name = current_customer.name
      @order.address = current_customer.address
    elsif params[:address_id] == 1
      if Address.exist?(name: params[:order][:registrated])
        @order.name = Address.find(params[:order][:registrated]).name
        @order.address = Address.find(params[:order][:registrated]).address
      else
        render :new
      end
    elsif params[:address_id] == 2
      address_new = current_customer.cart_items.all
      if address_new.save
      else
        render :new
      end
    else
      redirect_to public_thanks_path
    end
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) {|sum, item| sum + item.sum.sum_price }
  end

  def thanks
  end

  def index
  end

  def show
  end


  private

  def order_params
    params.require(:order).permit(:payment_method,:postal_code,:address,:name,:total_price,:address_id)
  end

  def address_params
  params.require(:order).permit(:name, :address,:address_id)
  end

end
