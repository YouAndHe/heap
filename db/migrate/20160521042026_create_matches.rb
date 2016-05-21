class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :key
      t.string :starter
      t.string :receiver

      t.timestamps null: false
    end
  end
end
