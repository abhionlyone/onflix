class Api::V1::ContentsController < Api::V1::ApiController
  def index
    @contents = Content.cached_results
    render json: ContentSerializer.new(@contents)
  end

  def movies
    @contents = Movie.cached_results
    render json: ContentSerializer.new(@contents)
  end

  def seasons
    @contents = Season.cached_results
    render json: ContentSerializer.new(@contents)
  end

  def purchase
    @variant = Variant.find(params[:variant_id])
    purchase = current_user.purchases.create(variant: @variant, content: @variant.content)
    if purchase.save
      head :created
    else
      render_error(purchase.errors.full_messages.to_sentence, :unprocessable_entity)
    end
  end

  def library
    @purchases = current_user.library.includes(:content, :variant)
    render json: PurchaseSerializer.new(@purchases)
  end
end
