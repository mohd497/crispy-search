class Adword < SearchResult

  enum position: [:top, :right]

  validates :position, presence: true
end
