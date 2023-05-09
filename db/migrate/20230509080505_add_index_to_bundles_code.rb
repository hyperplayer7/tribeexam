class AddIndexToBundlesCode < ActiveRecord::Migration[7.0]
  def change
    add_index :bundles, :code
  end
end
