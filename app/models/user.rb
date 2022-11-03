class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: [:manager, :developer, :qa]
  has_and_belongs_to_many :projects
  has_many :created_bugs, class_name: "Bug", foreign_key: "creator_id"
  has_many :solved_bugs, class_name: "Bug", foreign_key: "solver_id"
  validates :username, presence: true
  validates :username, uniqueness: {case_sensitive: false}

end
