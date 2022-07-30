class Admin::HomesController < ApplicationController
  def index
    @orders = Order.all
  end
end
