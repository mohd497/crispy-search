class Keyword < ActiveRecord::Base

  has_many :adwords
  has_many :non_adwords

  validates :text, presence: true, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :adwords, reject_if: :no_reference
  accepts_nested_attributes_for :non_adwords, reject_if: :no_reference

  private

  def no_reference(attributes)
    # Some of search result is a suggestion, map or image so it not count
    attributes[:title].blank? || attributes[:url].blank?
  end
end
