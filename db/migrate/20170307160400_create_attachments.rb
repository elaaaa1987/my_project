class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.integer :attachable_id
      t.string :attachable_type
      t.has_attached_file :attachment
      t.timestamps null: false
    end
  end
end
