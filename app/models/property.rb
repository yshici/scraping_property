class Property < ApplicationRecord
  validates :title, presence: true
  validates :access, presence: true
  validates :price, presence: true
  validates :floor, presence: true
  validates :area, presence: true
  validates :stair, presence: true
  validates :url, presence: true

  def self.fetch_tokyo_property
    url = 'https://www.fudousan.or.jp/property/rent/13/area/list?m_adr%5B%5D=13101&m_adr%5B%5D=13102&m_adr%5B%5D=13103&m_adr%5B%5D=13104&m_adr%5B%5D=13105&m_adr%5B%5D=13106&m_adr%5B%5D=13107&m_adr%5B%5D=13108&m_adr%5B%5D=13109&m_adr%5B%5D=13110&m_adr%5B%5D=13111&m_adr%5B%5D=13112&m_adr%5B%5D=13113&m_adr%5B%5D=13114&m_adr%5B%5D=13115&m_adr%5B%5D=13116&m_adr%5B%5D=13117&m_adr%5B%5D=13118&m_adr%5B%5D=13119&m_adr%5B%5D=13120&m_adr%5B%5D=13121&m_adr%5B%5D=13122&m_adr%5B%5D=13123&ptm%5B%5D=0303&price_r_from=&price_r_to=130000&mng_in_price%5B%5D=true&keyword=&eki_walk=10&bus_walk=&exclusive_area_from=&exclusive_area_to=&exclusive_area_from=&exclusive_area_to=&floor_plan%5B%5D=2XXSLDK&floor_plan%5B%5D=3XXXXSK&floor_plan%5B%5D=3XXXSDK&floor_plan%5B%5D=3XXSLDK&floor_plan%5B%5D=4XXXXSK&floor_plan%5B%5D=4XXXSDK&floor_plan%5B%5D=4ZZZZZZ&built=10'

    agent = Mechanize.new
    page = agent.get(url)

    page.search('.list-group-item').each do |el|
      title = el.at('span.prop-title-link:first-child').text + el.at('span.prop-title-link:nth-child(2)').text.strip
      access = el.at('.access').text.strip
      price = el.at('.price strong').text
      floor = el.at('.list-info li:first-child').text.strip
      area = el.at('.list-info li:nth-child(2)').text.strip.gsub(/\s+/, ' ')
      stair = el.at('.list-info li:nth-child(3)').text.strip.gsub(/\s+/, ' ')
      url = "https://www.fudousan.or.jp" + el.at('.prop-title-link').get_attribute(:href)

      record = self.find_or_initialize_by(title: title, access: access, price: price, floor: floor, area: area, stair: stair, url: url)
      record.save!
    end
  end
end
