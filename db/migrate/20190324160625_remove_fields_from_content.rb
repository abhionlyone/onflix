class RemoveFieldsFromContent < ActiveRecord::Migration[5.2]
  def change
    remove_column :contents, :price, :float
    remove_column :contents, :quality, :string
  end
end
