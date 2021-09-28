class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :create]

  def index
    @item = Item.find(params[:item_id])
    @order = RecordAddress.new
  end

  def create
    @order = RecordAddress.new(order_params)
    if @order.valid?
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end
end
