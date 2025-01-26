class AddSoftDeleteToMessages < ActiveRecord::Migration[8.0]
  def change
    add_column :messages, :deleted_by_sender, :boolean
    add_column :messages, :deleted_by_receiver, :boolean
  end
end
