class DeleteTitleUrlIdUniqIndexFromPropery < ActiveRecord::Migration[6.0]
  def change
    remove_index :properties, [:title, :url]
  end
end
