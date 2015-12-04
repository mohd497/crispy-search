require 'csv'

class Keyword < ActiveRecord::Base
  has_many :adwords, dependent: :destroy
  has_many :non_adwords, dependent: :destroy

  validates :text, presence: true, uniqueness: { case_sensitive: false }

  accepts_nested_attributes_for :adwords, reject_if: :no_reference
  accepts_nested_attributes_for :non_adwords, reject_if: :no_reference

  after_create :generate_report

  scope :last_update, -> { order('updated_at desc') }

  def self.create_form_csv(csv)
    data = if csv.kind_of?(String)
             CSV.parse(csv)
           elsif csv.kind_of?(File)
             CSV.read(csv)
           else
             raise 'Invalid CSV format'
           end

    ActiveRecord::Base.transaction do
      data.flatten.uniq.map do |keyword|
        Keyword.find_or_create_by(text: keyword)
      end
    end
  end


  private

  def no_reference(attributes)
    # Some of search result is a suggestion, map or image so it not count
    attributes[:title].blank? || attributes[:url].blank?
  end

  def generate_report
    # TODO: Sidekiq is too fast. (Google block ip when testing with 500+ record)
    # TODO: Find the way to run it without get block.

    SearchGoogleJob.perform_later(self) # Let's sidekiq ROCK!!
  end
end
