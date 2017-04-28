class Conversation < ActiveRecord::Base
  # Conversation ModelからはUser Modelを(.userメソッドではなく)sender or recipient メソッドで参照
  # conversationsテーブルの外部キーはsender_id or recipient_id フィールド
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy
  
  # commentsデーブルに、同一のrecipient_idに対するsender_idは一意である。
  # 特定の二人のConversationはひとつ
  validates_uniqueness_of :sender_id, :scope => :recipient_id

  #scopeは長い条件文を省略するために使用
  scope :involving, -> (user) do
    where("conversations.sender_id =? OR conversations.recipient_id =?",user.id,user.id)
  end

  scope :between, -> (sender_id,recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end
end