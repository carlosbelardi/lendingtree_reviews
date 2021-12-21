# frozen_string_literal: true
require 'rails_helper'
require Rails.root.join('spec/support/mock_response')

RSpec.describe Api::V1::ReviewsController, type: :controller do
  let(:test_url) { 'https://www.lendingtree.com/reviews/mortgage/reliance-first-capital-llc/45102840' }
  let(:broken_url) { 'https://www.lendingtree.com/abcd' }
  let(:bogus_url) { 'sloppysteaks' }

  let(:good_example_webpage) do
    File.read(
      Rails.root.join('spec', 'support', 'example_webpage.html')
    )
  end

  let(:no_reviews_webpage) do
    File.read(
      Rails.root.join('spec', 'support', 'no_reviews_webpage.html')
    )
  end

  let(:successful_response) do
    File.read(
      Rails.root.join('spec', 'support', 'successful_response.json')
    )
  end

  let(:bad_url_error) { { 'error' => 'URL is invalid or not for lendingtree.com' } }
  let(:no_page_error) { { 'error' => 'Page was not found' } }
  let(:no_review_error) { { 'error' => 'No reviews found for given URL' } }
  let(:mocked_good_response) { MockResponse.new(good_example_webpage) }
  let(:mocked_no_reviews_response) { MockResponse.new(no_reviews_webpage) }

  describe '#index' do
    context 'successful response' do
      before(:each) do
        expect(HTTParty).to receive(:get).with(test_url).and_return(mocked_good_response)
      end

      it 'returns reviews for a given url' do
        response = get(:index, params: { url: test_url })
        expect(JSON.parse(response.body)).to eq(JSON.parse(successful_response))
      end
    end

    context 'errors' do
      it 'returns an error when no url is passed' do
        response = get(:index, params: { url: '' })
        expect(JSON.parse(response.body)).to eq(bad_url_error)
      end

      it 'returns an error when bogus url is passed' do
        response = get(:index, params: { url: bogus_url })
        expect(JSON.parse(response.body)).to eq(bad_url_error)
      end

      it 'returns an error when a non lendingtree url is passed' do
        response = get(:index, params: { url: 'https://www.google.com' })
        expect(JSON.parse(response.body)).to eq(bad_url_error)
      end

      it 'returns an error when HTTParty call fails' do
        response = get(:index, params: { url: broken_url })
        expect(JSON.parse(response.body)).to eq(no_page_error)
      end

      it 'returns an error when page has no reviews' do
        expect(HTTParty).to receive(:get).with(test_url).and_return(mocked_no_reviews_response)
        response = get(:index, params: { url: test_url })
        expect(JSON.parse(response.body)).to eq(no_review_error)
      end
    end
  end
end
