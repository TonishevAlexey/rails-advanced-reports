class CreateGrades < ActiveRecord::Migration[6.1]
  def change
    create_table :grades do |t|
      t.integer :value
      t.references :gradable, polymorphic: true

      t.timestamps
    end
  end
end
