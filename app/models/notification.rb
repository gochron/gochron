class Notification
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sadstory

  #field :notif_resource
  #field :notif_resource_id
  
  field :event_id, type: String
  field :title, type: String
  field :text, type: String
  field :seen, type: Boolean

  belongs_to :user

     
end

