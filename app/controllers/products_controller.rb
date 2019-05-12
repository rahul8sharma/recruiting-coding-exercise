class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def change_currency
    session[:current_currency] = params[:currency_type]

    begin
      @products_with_id_and_price = Product.where(id: params[:product_ids].split(',')).map{|p| [p.id, p.get_price_by_currency(current_currency)]}
      respond_to do |format|
        format.js
      end
    rescue ActiveRecord::RecordNotFound => e
      format.js {
        render layout: false, content_type: 'text/javascript'
      }
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price_in_cents)
  end
end
