require 'csv'

class Keyword < ActiveRecord::Base
  has_many :adwords
  has_many :non_adwords

  validates :text, presence: true, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :adwords, reject_if: :no_reference
  accepts_nested_attributes_for :non_adwords, reject_if: :no_reference

  after_create :generate_report

  def self.create_form_csv(file)
    keywords = CSV.read(file).flatten.uniq.map { |keyword| { text: keyword } }

    # Tried of this google blocked my ip
    # ActiveRecord::Base.transaction { Keyword.create(keywords) }
    Keyword.create(keywords)
  end

  private

  def no_reference(attributes)
    # Some of search result is a suggestion, map or image so it not count
    attributes[:title].blank? || attributes[:url].blank?
  end

  def generate_report
    SearchGoogleJob.perform_later(self) # Let's sidekiq do the rest
  end
end
