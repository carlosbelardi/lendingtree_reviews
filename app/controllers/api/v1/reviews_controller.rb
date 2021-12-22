# frozen_string_literal: true
class Api::V1::ReviewsController < ApplicationController
  before_action :extract_params_url, only: [:index]

  def index
    return render_error('URL is invalid or not for lendingtree.com', status: :bad_request) unless @parsed_url.is_a?(URI::HTTP) && @parsed_url.host == 'www.lendingtree.com'

    if @page_id.present?
      http_response = grab_response(@url + "&pid=#{@page_id}")
    else
      http_response = grab_response(@url)
    end

    return render_error('Page was not found', status: :not_found) if http_response.nil?

    payload = extract_review_data(http_response.body)
    return render_error(payload, status: :bad_request) if payload.is_a?(String)

    render_json(body: payload)
  end

  private

  def extract_params_url
    @url = params[:url]
    @parsed_url = URI.parse(@url)
    @page_id = params[:pid]
  end

  def extract_review_data(http_response)
    data = []
    page = Nokogiri::HTML(http_response)
    page_reviews = page.css('div.mainReviews')
    return 'No reviews found for given URL' unless page_reviews.present?

    page_reviews.each do |page_review|
      data << parse_review(page_review)
    end
    data
  end

  def grab_response(url)
    http_response = HTTParty.get(url)
    return nil unless http_response.code == 200

    http_response
  end

  def parse_date(review)
    new_date = review.css('div.reviewDetail').css('div.hideText').css('p.consumerReviewDate').text
                    .gsub(/^Reviewed in/, '')
                    .strip
    return nil unless new_date.present?

    Date.parse(new_date).to_s
  end

  def parse_review(review)
    {
      title: review.css('div.reviewDetail').css('p.reviewTitle').text.strip,
      details: review.css('div.reviewDetail').css('p.reviewText').text.strip,
      stars: review.css('div.starReviews').css('div.rating-stars-wrapper').css('div.rating-stars-bottom')
                   .css('span.lt4-Star').length,
      author: review.css('div.reviewDetail').css('div.hideText').css('p.consumerName').children[0].text.strip,
      date: parse_date(review),
      author_location: review.css('div.reviewDetail').css('div.hideText').css('p.consumerName').css('span').text
                      .gsub(/^from/, '')
                      .strip,
    }
  end

  def render_error(message, status: :internal_server_error)
    render(json: { error: message }, status: status)
  end

  def render_json(body: nil, status: :ok)
    render(json: { reviews: body }, status: status)
  end
end
