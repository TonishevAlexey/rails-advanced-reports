class CreateGradings < ActiveRecord::Migration[6.1]
  def change
    create_table :gradings do |t|
      t.references :grade, foreign_key: true
      t.references :user, foreign_key: true
      t.string :kind, default: "default"

      t.timestamps
    end
  end
end
