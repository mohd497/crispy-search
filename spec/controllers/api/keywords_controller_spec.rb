require 'rails_helper'

RSpec.describe Api::KeywordsController, type: :controller do

  let(:token) { double :acceptable? => true }

  before(:all) {@keywords = create_list(:keyword, 10)}

  before do
    allow(controller).to receive(:doorkeeper_token) { token }
  end

  describe '[GET] #index' do

    it 'responds with 200' do
      get :index, format: :json
      expect(response.status).to eq(200)
    end

    it 'return list of first 5 keywords' do
      get :index, format: :json

      json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(json['keywords'].length).to eq(5)
    end
  end

  describe '[GET] #show' do

    it 'responds with 200' do
      get :show, id: @keywords.sample.id, format: :json
      expect(response.status).to eq(200)
    end

    it 'retrieve a specific keyword' do
      keyword = @keywords.sample

      get :show, id: keyword.id, format: :json

      json = JSON.parse(response.body)
      keyword_json = KeywordSerializer.new(keyword)

      expect(response.status).to eq(200)
      expect(json.to_json).to eq(keyword_json.to_json)
    end
  end

  describe '[POST] #create' do

  end

end
