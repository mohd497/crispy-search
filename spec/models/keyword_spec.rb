require 'rails_helper'

RSpec.describe Keyword, type: :model do

  describe '#no_reference' do

    before(:all) do
      @keyword = Keyword.new
    end

    it 'return true when title or url are blank or missing' do
      invalid_data = [
          { title: 'hello world' },
          { title: 'hello world', url: '' },
          { title: 'hello world', url: nil }
      ]
      invalid_data.each {|data| expect(@keyword.send(:no_reference, data)).to be_truthy }
    end

    it 'return false when title or url are provided' do
      data = { title: 'hello world', url: 'https://google.com' }

      expect(@keyword.send(:no_reference, data)).to be_falsey
    end
  end

end
