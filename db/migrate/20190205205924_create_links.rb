class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :title
      t.string :link
      t.text :body

      t.timestamps
    end
  end
end
