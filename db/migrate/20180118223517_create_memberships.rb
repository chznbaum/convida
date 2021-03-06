class CreateMemberships < ActiveRecord::Migration[5.1]
  def change
    create_table :memberships do |t|
      t.references :account, foreign_key: true
      t.references :user, foreign_key: true
      t.string :role, null: false

      t.timestamps
    end
  end
end
