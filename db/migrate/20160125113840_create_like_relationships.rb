class CreateLikeRelationships < ActiveRecord::Migration
  def change
    create_table :like_relationships do |t|
      t.references :like, index: true
      t.references :liked, index: true

      t.timestamps null: false
      t.index [:like_id, :liked_id], unique: true # この行を追加
    end
  end
end
