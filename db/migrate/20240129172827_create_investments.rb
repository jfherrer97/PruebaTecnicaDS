class CreateInvestments < ActiveRecord::Migration[7.1]
  def change
    create_table :investments do |t|
      t.float :price
      t.references :cryptocoins, null: false, foreign_key: true

      t.timestamps
    end
  end
end
