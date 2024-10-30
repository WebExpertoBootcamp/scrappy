class ScrapingJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info "ScrapingJob started"
    Link.find_each do |link|
      url = link.url
      category = link.category
      scraper_type = link.scraper
      scraper_selector(url, category.id, scraper_type)
    end
    Rails.logger.info "ScrapingJob finished"
  end

  private
  def scraper_selector(url, category, scraper_type)
    case scraper_type
    when "japangameonline"
      ScrapeJapangame.scrape(url, category)
    when "compragamer"
      ScrapeCompragamer.scrape(url, category)
    else
      Rails.logger.error "No se encontró un scraper para la categoría #{category.name}."
    end
  end
end
