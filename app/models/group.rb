class Group
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sadstory
  field :name, type: String
  field :description, type: String

  has_many :events
  has_and_belongs_to_many :subscribers, class_name: "User", inverse_of: :subscribed_groups
  belongs_to :user

  validates :name,:description,presence: true
end

