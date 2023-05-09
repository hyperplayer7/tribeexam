class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :submission_format
      t.text :result

      t.timestamps
    end
  end
end
