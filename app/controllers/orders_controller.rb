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
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private
  def order_params
    params.require(:record_address).permit(:postal_code, :prefecture_id, :municipalities, :address, :building_name, :tel_num).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
