# frozen_string_literal: true
class Api::V1::ReviewsController < ApplicationController
  before_action :extract_params_url, :only => [:index]

  def index
    byebug
    http_response = grab_response(@url)
    review_response = extract_review_data(http_response.body)
    render_json(body: review_response)
  end

  private

  def extract_params_url
    @url = params[:url]
  end

  def extract_review_data(http_response)
    byebug
    data = []
    page = Nokogiri::HTML(http_response)
    page_reviews = page.css('div.mainReviews')
    page_reviews.each do |page_review|
      data << parse_review(page_review)
    end
    byebug
    data
  end

  def grab_response(url)
    byebug
    response = HTTParty.get(url)
    { error: 'URL extraction failed', error_code: response.code.to_s, status: :not_found } if response.code != 200
    response
  end

  def parse_date(review)
    new_date = review.css('div.reviewDetail').css('div.hideText').css('p.consumerReviewDate').text
                     .gsub(/^Reviewed in/, '')
                     .strip
    Date.parse(new_date).to_s
  end

  def parse_review(review)
    {
      title: review.css('div.reviewDetail').css('p.reviewTitle').text,
      details: review.css('div.reviewDetail').css('p.reviewText').text,
      stars: review.css('div.starReviews').css('div.rating-stars-wrapper').css('div.rating-stars-bottom')
                   .css('span.lt4-Star').length,
      author: review.css('div.reviewDetail').css('div.hideText').css('p.consumerName').children[0].text.strip,
      date: parse_date(review),
      location: review.css('div.reviewDetail').css('div.hideText').css('p.consumerName').css('span').text
                      .gsub(/^from/, '')
                      .strip,
    }
  end

  def payload_has_error?(payload)
    return payload.key?(:error) unless payload.nil? || !payload.is_a?(Hash)
  end

  def render_json(body: nil, status: :ok, error: nil)
    render(json: { result: body, error: error }, status: status)
  end
end
