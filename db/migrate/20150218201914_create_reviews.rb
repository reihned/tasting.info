class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer   :author_id
      t.integer   :product_id
      t.text      :content
      t.boolean   :positive
    end
  end
end
