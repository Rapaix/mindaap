class Tag < ApplicationRecord
  belongs_to :user
  validates :name, presence: true, uniqueness: { scope: :user_id }
  # Ex:- scope :active, -> {where(:active => true)}}
end
