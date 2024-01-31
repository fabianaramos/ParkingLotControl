class CreateParkings < ActiveRecord::Migration[7.1]
  def change
    create_table :parkings do |t|
      t.string :plate, null: false, index: true
      t.boolean :paid, null: false, default: false
      t.boolean :left, null: false, default: false
      t.datetime :paid_at

      t.timestamps
    end
  end
end
