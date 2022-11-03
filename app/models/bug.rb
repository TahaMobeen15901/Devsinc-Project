





class Bug < ApplicationRecord
  has_one_attached :image
  belongs_to :project
  belongs_to :creator, class_name:"User"
  belongs_to :solver, class_name:"User", :optional => true
  attribute :title, :text, default: ""
  validates :title, :types_status, :bug_type, :deadline, presence: true
  validates :title, uniqueness: {case_sensitive: false}
  validate :acceptable_image
  def acceptable_image
    return unless image.attached?
    acceptable_types = ["image/gif", "image/png"]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be png or gif")
    end
  end
end
