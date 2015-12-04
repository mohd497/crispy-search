class NonAdword < SearchResult
  belongs_to :keyword, counter_cache: true
end
