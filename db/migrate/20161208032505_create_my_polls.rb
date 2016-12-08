class CreateMyPolls < ActiveRecord::Migration[5.0]
  def change
    create_table :my_polls do |t|
      t.references :user, foreign_key: true
      t.text :description
      t.datetime :expires_at
      t.string :title

      t.timestamps
    end
  end
end
