class CreateChildren < ActiveRecord::Migration[5.1]
  def change
    create_table :children do |t|
      t.references :account, foreign_key: true
      t.string :first_name, null: false, default: ""
      t.date :birthdate, null: false
      t.string :pronoun, null: false, default: "they"
      t.json :avatar

      t.timestamps
    end
  end
end
