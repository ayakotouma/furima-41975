class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :move_to_root_if_seller, only: [:edit, :update, :destroy]
  before_action :move_to_root_if_sold_out, only: [:edit, :update, :destroy]

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @purchase_form = PurchaseForm.new
  end

  def create
    @purchase_form = PurchaseForm.new(purchase_params)
    if @purchase_form.valid?
      pay_item
      @purchase_form.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  private

  # 出品者は購入ページにアクセスできないようにする
  def move_to_root_if_seller
    return unless @item.user_id == current_user.id

    redirect_to root_path
  end

  # 売却済み商品は購入ページにアクセスできないようにする
  def move_to_root_if_sold_out
    return unless @item.purchase_record.present?

    redirect_to root_path
  end

  def purchase_params
    params.require(:purchase_form).permit(:postal_code, :prefecture_id, :city, :address, :building_name,
                                          :phone_number).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] # 自身のPAY.JPテスト秘密鍵を記述しましょう
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: purchase_params[:token], # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end
end
