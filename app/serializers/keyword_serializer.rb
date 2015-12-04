class KeywordSerializer < ActiveModel::Serializer
  attributes :id, :text, :total_result, :total_links_count, :non_adwords_count, :adwords_count
  has_many :adwords
  has_many :non_adwords
end
