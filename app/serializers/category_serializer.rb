class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :scrappers
  def scrappers
    object.links.map do |link|
      link.scraper
    end
  end
end