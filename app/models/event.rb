class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  field :title, type: String
  field :datetime, type: String
  field :description, type: String
  field :location, type: String
  field :link, type: String
  field :access_type, type: String
  validates :title,:datetime,:description,:location,:access_type,presence: true
end
