# frozen_string_literal: true
class Api::V1::ReviewsController < ApplicationController
  before_action :extract_params_url, :only => [:index]

  def index
    byebug
    response = build_response(@url)
  end

  private

  def extract_params_url
    @url = params[:url]
  end

  def build_response(url)
    byebug
    HTTParty.get(url)
  end
end
