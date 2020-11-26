namespace :scheduler do
  desc "東京物件検索"
  task fetch_tokyo_property: :environment do
    Property.fetch_tokyo_property
  end

  desc "神奈川物件検索"
  task fetch_kanagawa_property: :environment do
    Property.fetch_kanagawa_property
  end
end
