class CreateBills < ActiveRecord::Migration[5.2]
  def change
    create_table :bills do |t|
      t.string :name
      t.decimal :amount
      t.string :category
      t.boolean :recurring
      t.date :due_date
      t.references :user, foreign_key: {on_delete: :cascade}

      t.timestamps null: false
    end
  end
end
