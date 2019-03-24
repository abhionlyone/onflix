class Api::V1::ContentsController < Api::V1::ApiController
  def index
    @contents = Content.includes(:assets, :variants)
    render json: ContentSerializer.new(@contents)
  end

  def movies
    @contents = Movie.includes(:assets, :variants)
    render json: ContentSerializer.new(@contents)
  end

  def seasons
    @contents = Season.includes(:assets, :variants)
    render json: ContentSerializer.new(@contents)
  end

  def purchase
    @variant = Variant.find(params[:variant_id])
    purchase = current_user.purchases.create(variant: @variant, content: @variant.content)
    if purchase.save
      puts "#{purchase.inspect}"
      render json: PurchaseSerializer.new(@purchase)
    else
      render json: purchase.errors.full_messages, status: 422
    end
  end

  def my_purchases
    @purchases = current_user.purchases.alive.includes(:content)
    render json: PurchaseSerializer.new(@purchases)
  end
end
