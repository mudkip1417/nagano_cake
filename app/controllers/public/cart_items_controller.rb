class Public::CartItemsController < ApplicationController

  def index
    @cart_items = CartItem.all
    @cart_item = CartItem.new
    @total_payment = current_customer.cart_items.cart_items_total_payment(@cart_items)
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if params[:cart_item][:amount] == "0"
      @cart_item.destroy
      redirect_to public_cart_items_path
    elsif @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to public_cart_items_path
    else
      @cart_items = current_customer.cart_items
      @total_payment = 0
      render "public/cart_items/index"
    end
  end

  def create
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to public_cart_items_path
    elsif @cart_item.save
      @cart_items = current_customer.cart_items.all
      @total_payment = current_customer.cart_items.cart_items_total_payment(@cart_items)
      render 'index'
    else
      render 'index'
    end
  end

  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to public_cart_items_path
  end

  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    redirect_to public_cart_items_path
  end

  private
  def cart_item_params
      params.require(:cart_item).permit(:item_id, :amount,)
  end

end
