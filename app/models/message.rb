class Message < ApplicationRecord
  belongs_to :sender, class_name: 'User', foreign_key: 'sender_id'
  belongs_to :receiver, class_name: 'User', foreign_key: 'receiver_id'

  validates :content, presence: true

  # Scope to get messages that have not been soft-deleted by the user
  scope :visible_to, ->(user) {
    where(
      "(sender_id = :user_id AND (deleted_by_sender IS NULL OR deleted_by_sender = false)) OR
      (receiver_id = :user_id AND (deleted_by_receiver IS NULL OR deleted_by_receiver = false))",
      user_id: user.id
    )
  }

  def sender_username
    sender.username
  end

  def receiver_username
    receiver.username
  end
end
