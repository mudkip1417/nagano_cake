class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def create
    @address = Address.new(address_paramas)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to public_customer_path
    end
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:name,:postal_code,:address)
  end

end

