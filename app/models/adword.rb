class Adword < SearchResult
  belongs_to :keyword, counter_cache: true

  enum position: [:top, :right]

  validates :position, presence: true
end
