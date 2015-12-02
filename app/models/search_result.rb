class SearchResult < ActiveRecord::Base
  belongs_to :keyword

  validates_presence_of :keyword, :title, :url
end
