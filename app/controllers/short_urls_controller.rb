# controller for ShortUrls
class ShortUrlsController < ApplicationController
  before_action :authenticate_user!
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @urls = ShortUrl.all.where(user_id: current_user.id)
  end

  def show
    @url = ShortUrl.find(params[:id])
    @tiny_url = "#{request.host_with_port}/#{@url.tiny_url}"
  end

  def new
    @short_url = ShortUrl.new
  end

  def create
    @url = ShortUrl.new(short_url_params)
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
    @url.destroy
    redirect_to short_urls_path, notice: t(:destroyed)
  end

  private

  def short_url_params
    params.require(:short_url).permit(:long_url, :user_id)
  end

  def not_found(exception)
    redirect_to short_urls_path, alert: t('record_not_found', my_object: ShortUrl.model_name.name, params: (params[:id] || params[:url_shortened]).to_s)
  end
end
