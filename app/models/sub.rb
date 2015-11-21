class Sub < ActiveRecord::Base
  validates :title, :user_id, :description, presence: true

  belongs_to :moderator,
    foreign_key: :user_id,
    class_name: 'User'


end
