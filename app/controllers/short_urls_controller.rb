class ShortUrlsController < ApplicationController
  before_action :authenticate_user!

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
    @url = ShortUrl.find_by_tiny_url(params[:url_shortened])
    redirect_to @url.long_url, allow_other_host: true
  end

  private

  def short_url_params
    params.require(:short_url).permit(:long_url, :user_id)
  end
end
