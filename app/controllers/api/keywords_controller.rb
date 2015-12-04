class Api::KeywordsController < ApplicationController
  respond_to :json

  skip_before_action :authenticate_user! # let's doorkeeper ROCK
  before_action :doorkeeper_authorize!

  def index
    @q = Keyword.ransack(params[:q])
    @keywords = @q.result.includes(:adwords).page(params[:page]).per(params[:per_page])

    respond_with @keywords
  end

  def show
    respond_with Keyword.find(params[:id])
  end

  def create
    csv_content = params[:csv_file] ? params[:csv_file].read : nil

    if csv_content.blank?
      render json: { error: 'Cannot read csv file or content empty.' }, status: 201
    else
      Keyword.create_form_csv(params[:file])
      render nothing: true, status: 201
    end

  end

  def cache_page
    render json: Keyword.find(params[:id]), serializer: CachePageSerializer, status: 200
  end
end
