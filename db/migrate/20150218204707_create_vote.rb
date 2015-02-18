class CreateVote < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer   :review_id
      t.boolean   :positive
    end
  end
end
