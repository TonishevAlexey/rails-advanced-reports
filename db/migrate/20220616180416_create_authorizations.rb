class CreateAuthorizations < ActiveRecord::Migration[6.1]
  def change
    create_table :authorizations do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.string :provider
      t.string :uid
      t.timestamps
    end

    add_index :authorizations, [:provider, :uid]
  end
end
