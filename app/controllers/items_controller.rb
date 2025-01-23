class ItemsController < ApplicationController
  def index
  end
end

private

def item_params
  params.require(:item).permit(
    :name,
    :description,
    :category_id,
    :condition_id,
    :shipping_fee_id,
    :prefecture_id,
    :shipping_day_id,
    :price,
    :image
  ).merge(user_id: current_user.id)
end
