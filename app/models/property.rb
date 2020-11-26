require 'open-uri'

class Property < ApplicationRecord
  validates :title, presence: true
  validates :access, presence: true
  validates :price, presence: true
  validates :floor, presence: true
  validates :area, presence: true
  validates :stair, presence: true
  validates :url, presence: true
  has_one_attached :image

  def self.fetch_tokyo_property
    url = 'https://www.fudousan.or.jp/property/rent/13/area/list?m_adr%5B%5D=13101&m_adr%5B%5D=13102&m_adr%5B%5D=13103&m_adr%5B%5D=13104&m_adr%5B%5D=13105&m_adr%5B%5D=13106&m_adr%5B%5D=13107&m_adr%5B%5D=13108&m_adr%5B%5D=13109&m_adr%5B%5D=13110&m_adr%5B%5D=13111&m_adr%5B%5D=13112&m_adr%5B%5D=13113&m_adr%5B%5D=13114&m_adr%5B%5D=13115&m_adr%5B%5D=13116&m_adr%5B%5D=13117&m_adr%5B%5D=13118&m_adr%5B%5D=13119&m_adr%5B%5D=13120&m_adr%5B%5D=13121&m_adr%5B%5D=13122&m_adr%5B%5D=13123&ptm%5B%5D=0303&price_r_from=&price_r_to=130000&mng_in_price%5B%5D=true&keyword=&eki_walk=10&bus_walk=&exclusive_area_from=&exclusive_area_to=&exclusive_area_from=&exclusive_area_to=&floor_plan%5B%5D=2XXSLDK&floor_plan%5B%5D=3XXXXSK&floor_plan%5B%5D=3XXXSDK&floor_plan%5B%5D=3XXSLDK&floor_plan%5B%5D=4XXXXSK&floor_plan%5B%5D=4XXXSDK&floor_plan%5B%5D=4ZZZZZZ&built=10'

    agent = Mechanize.new
    page = agent.get(url)

    new_properties = []
    page.search('.list-group-item').each do |el|
      title = el.at('span.prop-title-link:first-child').text + el.at('span.prop-title-link:nth-child(2)').text.strip
      access = el.at('.access').text.strip
      price = el.at('.price strong').text
      floor = el.at('.list-info li:first-child').text.strip
      area = el.at('.list-info li:nth-child(2)').text.strip.gsub(/\s+/, ' ')
      stair = el.at('.list-info li:nth-child(3)').text.strip.gsub(/\s+/, ' ')
      deposit = el.at('.list-info li:nth-child(6)').text.strip.gsub(/\s+/, ' ')
      management = el.at('.list-info li:nth-child(7)').text.strip.gsub(/\s+/, ' ')
      url = "https://www.fudousan.or.jp" + el.at('.prop-title-link').get_attribute(:href)
      image = el.at('img')['data-echo'] + ".jpg"
      io = URI.open(image)

      record = self.find_or_initialize_by(title: title, access: access, price: price, floor: floor, area: area, stair: stair, deposit: deposit, management: management, url: url)
      if record.new_record?
        record.save!
        record.image.attach(io: io, filename: "image-#{record.id}.jpg")
        new_properties << record
      else
        logger.info "[INFO] Already saved."
      end
    end
    PropertyTokyoMailer.notification(new_properties).deliver_now if new_properties.present?
  end

  def self.fetch_kanagawa_property
    url = 'https://www.fudousan.or.jp/property/rent/14/area/list?m_adr%5B%5D=14101&m_adr%5B%5D=14102&m_adr%5B%5D=14103&m_adr%5B%5D=14104&m_adr%5B%5D=14105&m_adr%5B%5D=14106&m_adr%5B%5D=14107&m_adr%5B%5D=14108&m_adr%5B%5D=14109&m_adr%5B%5D=14110&m_adr%5B%5D=14111&m_adr%5B%5D=14112&m_adr%5B%5D=14113&m_adr%5B%5D=14114&m_adr%5B%5D=14115&m_adr%5B%5D=14116&m_adr%5B%5D=14117&m_adr%5B%5D=14118&m_adr%5B%5D=14131&m_adr%5B%5D=14132&m_adr%5B%5D=14133&m_adr%5B%5D=14134&m_adr%5B%5D=14135&m_adr%5B%5D=14136&m_adr%5B%5D=14137&ptm%5B%5D=0303&price_r_from=&price_r_to=130000&keyword=&eki_walk=10&bus_walk=&exclusive_area_from=&exclusive_area_to=&exclusive_area_from=&exclusive_area_to=&floor_plan%5B%5D=2XXSLDK&floor_plan%5B%5D=3XXXXSK&floor_plan%5B%5D=3XXXSDK&floor_plan%5B%5D=3XXSLDK&floor_plan%5B%5D=4XXXXSK&floor_plan%5B%5D=4XXXSDK&floor_plan%5B%5D=4ZZZZZZ&built=10'

    agent = Mechanize.new
    page = agent.get(url)

    new_properties = []
    page.search('.list-group-item').each do |el|
      title = el.at('span.prop-title-link:first-child').text + el.at('span.prop-title-link:nth-child(2)').text.strip
      access = el.at('.access').text.strip
      price = el.at('.price strong').text
      floor = el.at('.list-info li:first-child').text.strip
      area = el.at('.list-info li:nth-child(2)').text.strip.gsub(/\s+/, ' ')
      stair = el.at('.list-info li:nth-child(3)').text.strip.gsub(/\s+/, ' ')
      deposit = el.at('.list-info li:nth-child(6)').text.strip.gsub(/\s+/, ' ')
      management = el.at('.list-info li:nth-child(7)').text.strip.gsub(/\s+/, ' ')
      url = "https://www.fudousan.or.jp" + el.at('.prop-title-link').get_attribute(:href)

      record = self.find_or_initialize_by(title: title, access: access, price: price, floor: floor, area: area, stair: stair, deposit: deposit, management: management, url: url)
      if record.new_record?
        record.save!
        new_properties << record
      else
        logger.info "[INFO] Already saved."
      end
    end
    PropertyKanagawaMailer.notification(new_properties).deliver_now if new_properties.present?
  end
end
