class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sadstory
  field :title, type: String
  field :datetime, type: DateTime
  field :description, type: String
  field :location, type: String
  field :link, type: String
  field :access_type, type: String

  belongs_to :user
  belongs_to :group
  has_and_belongs_to_many :attendees, class_name: "User", inverse_of: :attending_events

  validates :title,:datetime,:description,:location,:access_type,presence: true
end
