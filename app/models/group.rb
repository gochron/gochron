class Group
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, type: String
  field :title, type: String
  field :description, type: String

end

