class CreateAlbums < ActiveRecord::Migration[5.1]
  def change
    create_table :albums do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
