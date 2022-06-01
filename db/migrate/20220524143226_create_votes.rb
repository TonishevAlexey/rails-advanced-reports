class CreateVotes < ActiveRecord::Migration[6.1]
  def change
    create_table :votes do |t|
      t.integer :value, default: 0
      t.references :votable, polymorphic: true
      t.references :user, null: false, foreign_key: true
      t.string :kind, default: "default"

      t.timestamps
    end
  end
end
