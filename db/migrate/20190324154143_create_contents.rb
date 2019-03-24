class CreateContents < ActiveRecord::Migration[5.2]
  def change
    create_table :contents do |t|
      t.string :title
      t.string :quality
      t.float :price
      t.string :type

      t.timestamps
    end
  end
end
