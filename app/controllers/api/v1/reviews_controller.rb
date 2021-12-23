# frozen_string_literal: true
class Api::V1::ReviewsController < ApplicationController
  before_action :extract_params_url, only: [:index]

  def index
    # If the url isn't a proper http url, or if it doesn't belong to lendingtree.com, throw an error
    return render_error('URL is invalid or not for lendingtree.com', status: :bad_request) unless @parsed_url.is_a?(URI::HTTP) && @parsed_url.host == 'www.lendingtree.com'

    # Here we decide to proceed with the basic url that gives the first page of results,
    # or one that is looking for results on a further page
    if @page_id.present?
      http_response = grab_response(@url + "&pid=#{@page_id}")
    else
      http_response = grab_response(@url)
    end

    # If the call to HTTParty further down failed, throw this error
    return render_error('Page was not found', status: :not_found) if http_response.nil?

    # The call to extract the review data. In the case we have no review data, our payload is just a string saying so,
    # and we render an error with that message
    payload = extract_review_data(http_response.body)
    return render_error(payload, status: :bad_request) if payload.is_a?(String)

    # At this point if everything has worked, render our json response
    render_json(body: payload)
  end

  private

  def extract_params_url
    # We extract data from our params. We also parse the URL to later check if it's in a proper http format
    @url = params[:url]
    @parsed_url = URI.parse(@url)
    @page_id = params[:pid]
  end

  def extract_review_data(http_response)
    # Create an array that'll house our reviews, then we'll create a Nokogiri object using our HTTParty response
    data = []
    page = Nokogiri::HTML(http_response)
    page_reviews = page.css('div.mainReviews')
    # If the webpage we're being directed to has no review objects, throw an error.
    return 'No reviews found for given URL' unless page_reviews.present?

    # Parse each review and insert it into our array, then return it
    page_reviews.each do |page_review|
      data << parse_review(page_review)
    end
    data
  end

  def grab_response(url)
    # Pass the url to HTTParty, which will verify if this url goes to a valid webpage.
    # If it returns anything other than a 200, then there was something wrong with the url provided
    http_response = HTTParty.get(url)
    return nil unless http_response.code == 200

    http_response
  end

  def parse_date(review)
    # I wanted to return dates in a proper format, so we go in an extra layer to extract that, then parse it
    # If by some weird occurence we don't have a date, it returns nil before the call to parse. Since parsing a nil object would throw an error
    new_date = review.css('div.reviewDetail').css('div.hideText').css('p.consumerReviewDate').text
                    .gsub(/^Reviewed in/, '')
                    .strip
    return nil unless new_date.present?

    Date.parse(new_date).to_s
  end

  def parse_review(review)
    # Access the elements we want to return, doing the necessary cleaning of unnecessary test, removing whitespace, etc
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
