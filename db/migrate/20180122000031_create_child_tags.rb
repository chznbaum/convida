class CreateChildTags < ActiveRecord::Migration[5.1]
  def change
    create_table :child_tags do |t|
      t.references :account, foreign_key: true
      t.references :child, foreign_key: true
      t.references :attachment, foreign_key: true

      t.timestamps
    end
  end
end
