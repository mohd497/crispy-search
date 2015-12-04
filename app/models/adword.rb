class Adword < SearchResult
  belongs_to :keyword, inverse_of: :adwords, counter_cache: true

  enum position: [:top, :right]

  validates :position, presence: true
end
