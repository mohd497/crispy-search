require 'rails_helper'

RSpec.describe KeywordsController, type: :controller do

  before(:all) do
    @user = create(:user)
    create_list(:keyword, 5)
  end

  describe '[GET] #index' do
    it 'assigns latest 5 keywords to @keywords' do
      keywords = Keyword.limit(5)

      get :index
      expect(assigns(:keywords)).to match_array(keywords)
    end
  end


  describe '[GET] #cache_page' do

    before(:all) do
      @keyword = Keyword.last
    end

    it 'assigns requested keyword to @keyword' do
      keyword = Keyword.find @keyword.id

      get :cache_page, id: @keyword.id
      expect(assigns(:keyword)).to eq(keyword)
    end

    it 'return cache html file' do
      get :cache_page, id: @keyword.id
      expect(response.header['Content-Type']).to eq('text/html')
    end
  end

  describe '[POST] #create' do

    it 'save new keywords data from csv to database and redirect to main page' do
      # TODO: Create file with faker then read it
      csv_file = fixture_file_upload('files/test.csv')

      keyword_count = Keyword.count

      sign_in @user
      post :create, csv_file: csv_file

      expect(Keyword.count).to eq(keyword_count + 5)
      expect(response).to redirect_to(root_path)
    end

  end

end
