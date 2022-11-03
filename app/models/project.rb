






class Project < ApplicationRecord
  has_many :bugs
  has_and_belongs_to_many :users
  validates :title, presence: true
  \
  attribute :title, :text, default: ""
end
