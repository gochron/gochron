class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sadstory
  include Mongoid::Paperclip

  field :name, type: String
  field :description, type: String

  has_many :events
  has_and_belongs_to_many :subscribers, class_name: "User", inverse_of: :subscribed_groups
  belongs_to :user

  has_mongoid_attached_file :image_attachment
  validates_attachment_file_name :image_attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

 validates :name,:description,presence: true
end

