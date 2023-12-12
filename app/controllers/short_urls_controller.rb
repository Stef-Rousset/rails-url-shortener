# controller for ShortUrls
class ShortUrlsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[url_shortened]
  before_action :skip_authorization, only: %i[url_shortened]
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @urls = policy_scope(ShortUrl)
  end

  def show
    @url = ShortUrl.find(params[:id])
    authorize @url
    @tiny_url = "#{request.host_with_port}/#{@url.tiny_url}"
  end

  def new
    @short_url = ShortUrl.new
    authorize @short_url
  end

  def create
    @url = ShortUrl.new(short_url_params)
    authorize @url
    if @url.save
      redirect_to short_url_path(@url)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def url_shortened
    @url = ShortUrl.find_by_tiny_url!(params[:url_shortened]) # bang added to raise an ActiveRecord::RecordNotFound error
    redirect_to @url.long_url, allow_other_host: true
  end

  def destroy
    @url = ShortUrl.find(params[:id])
    authorize @url
    @url.destroy
    redirect_to short_urls_path, notice: t(:destroyed, name: t(:short_url))
  end

  private

  def short_url_params
    params.require(:short_url).permit(:long_url, :user_id)
  end

  def not_found
    redirect_to short_urls_path, alert: t('record_not_found', my_object: ShortUrl.model_name.name, params: (params[:id] || params[:url_shortened]).to_s)
  end
end
