class CreateVariants < ActiveRecord::Migration[5.2]
  def change
    create_table :variants do |t|
      t.string :quality
      t.float :price
      t.references :content, foreign_key: true

      t.timestamps
    end
  end
end
