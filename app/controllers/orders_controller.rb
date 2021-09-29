class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_set
  before_action :move_top_page

  def index
    @order = RecordAddress.new
  end

  def create
    @order = RecordAddress.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      redirect_to root_path
    else
      render :index
    end
  end

  private
  def item_set
    @item = Item.find(params[:item_id])
  end

  def move_top_page
    if PurchaseRecord.exists?(item_id: @item.id) || current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def order_params
    params.require(:record_address).permit(:postal_code, :prefecture_id, :municipalities, :address, :building_name, :tel_num).merge(user_id: current_user.id, item_id: params[:item_id], token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
