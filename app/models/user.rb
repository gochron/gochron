class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable


  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  field :confirmation_token,   type: String
  field :confirmed_at,         type: Time
  field :confirmation_sent_at, type: Time
  field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  has_many :events
  has_many :groups
  has_many :notifications
  has_and_belongs_to_many :attending_events, class_name: "Event", inverse_of: :attendees
  has_and_belongs_to_many :subscribed_groups, class_name: "Group", inverse_of: :subscribers

  # all the events belonging to the groups the user has subscribed to
  # sorted in chronological order
  def subscribed_events
    Event.where(:group_id.in => subscribed_group_ids)
  end

  def upcoming_subscribed_events
    Event.where(:id.in => subscribed_group_ids, :datetime.gte => Date.today).order_by(datetime: 'asc')
  end

  def upcoming_attending_events
    Event.where(:id.in => attending_event_ids, :datetime.gte => Date.today).order_by(datetime: 'asc')
  end

  def username
    self.email.split('@')[0]
  end
end
