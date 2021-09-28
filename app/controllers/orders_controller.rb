class OrdersController < ApplicationController

  before_action :authenticate_user!, only: [:index, :create]

  def index
  end
end
