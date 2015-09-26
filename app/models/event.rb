class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  field :title, type: String
  field :datetime, type: DateTime
  field :description, type: String
  field :location, type: String
  field :link, type: String
  field :access_type, type: String

end
