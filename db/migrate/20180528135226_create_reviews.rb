class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating
      t.references :user, foreign_key: true, index: true
      t.references :route, foreign_key: true, index: true

      t.timestamps
    end
  end
end
