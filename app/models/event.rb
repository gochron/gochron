class Event
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Sadstory
  include Mongoid::Paperclip
	
  field :title, type: String
  field :datetime, type: DateTime
  field :description, type: String
  field :location, type: String
  field :link, type: String

  belongs_to :user
  belongs_to :group
  has_and_belongs_to_many :attendees, class_name: "User", inverse_of: :attending_events

  validates :title,:datetime,presence: true
  has_mongoid_attached_file :image_attachment
  validates_attachment_file_name :image_attachment, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]

  scope :upcoming, ->() { where(:datetime.gte => Date.today).order_by(datetime: 'asc') }

  scope :this_month, ->(d) {
    where(:datetime.gte => d.beginning_of_month.beginning_of_day, :datetime.lte => d.end_of_month.end_of_day)
        .order_by(datetime: 'asc')
  }

end
