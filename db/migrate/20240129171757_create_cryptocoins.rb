class CreateCryptocoins < ActiveRecord::Migration[7.1]
  def change
    create_table :cryptocoins do |t|
      t.string :name
      t.float :monthly_return

      t.timestamps
    end
  end
end
