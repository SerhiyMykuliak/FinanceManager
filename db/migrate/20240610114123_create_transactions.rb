class CreateTransactions < ActiveRecord::Migration[7.1]
  def change
    create_table :transactions do |t|
      t.string :category
      t.string :operation_type
      t.integer :amount
      t.string :description

      t.timestamps
    end
  end
end
