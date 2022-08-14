class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(current_customer.id)
    @customers = Customer.all
  end

  def edit
    @customer = Customer.find(current_customer.id)
  end

  def update
    @customer = Customer.find(current_customer.id)
    @customer.update(item_params)
    redirect_to public_customer_path(@customer.id)
  end

  def unsubscribe
    @customer = Customer.find_by(email: params[:email])
  end

  def withdraw
    @customer = Customer.find_by(email: params[:email])
    @customer.update(is_valid: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,:first_name,:last_name_kana,:first_name_kana,:email,:encrypted_password,:postal_code,:address,:telephone_number,:is_active)
  end

end


