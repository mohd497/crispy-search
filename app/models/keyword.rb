require 'csv'

class Keyword < ActiveRecord::Base
  has_many :adwords, inverse_of: :keyword, dependent: :destroy
  has_many :non_adwords, inverse_of: :keyword, dependent: :destroy

  validates :text, presence: true, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :adwords, reject_if: :no_reference
  accepts_nested_attributes_for :non_adwords, reject_if: :no_reference

  scope :popular, -> { order('hits desc') }

  def increase_hits
    update_attribute(:hits, self.hits+1)
  end


  private

  def no_reference(attributes)
    # Some of search result is a suggestion, map or image so it not count
    attributes[:title].blank? || attributes[:url].blank?
  end
end
