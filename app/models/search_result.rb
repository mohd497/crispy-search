class SearchResult < ActiveRecord::Base
  validates_presence_of :keyword, :title, :url
end
