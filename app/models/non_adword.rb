class NonAdword < SearchResult
  belongs_to :keyword, inverse_of: :non_adwords, counter_cache: true
end
