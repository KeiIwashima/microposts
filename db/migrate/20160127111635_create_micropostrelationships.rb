class CreateMicropostrelationships < ActiveRecord::Migration
  def change
    create_table :micropostrelationships do |t|
      t.references :micropost, index: true
      t.references :user, index: true
      
      t.timestamps null: false
      t.index [:micropost_id, :user_id], unique: true # この行を追加
    end
  end
end
