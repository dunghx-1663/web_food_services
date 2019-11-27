class User < ApplicationRecord
  CUSTOMER_OR_SHIPPER = [2, 4]

  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest

  has_many :comments, dependent: :destroy
  has_many :votes
  has_many :carts
  has_many :orders
  has_many :foods

  has_many :customer, through: :active_relationships, source: :customer
  has_many :shippers, through: :active_relationships, source: :employee

  has_many :active_relationships, class_name: "Order",foreign_key: "customer_id"
  has_many :passive_relationships, class_name: "Order",foreign_key: "employee_id"

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { maximum: 8 }, allow_nil: true
  enum role: {User: 0, Employee: 1, Admin: 2}

  # has_many :picture, dependent: :destroy, foreign_key: :user_id
  mount_uploader :avatar_url, AvatarUploader

  scope :shipper, -> {
    where(user_type: Settings.user_type.shipper)
  }

  class << self
    # return the hash digest of the given string
  	def digest(string)
  	  cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
  	                                                BCrypt::Engine.cost
  	  BCrypt::Password.create(string, cost: cost)
  	end

  	  #return a ramdom token
  	def new_token
  	  SecureRandom.urlsafe_base64
  	end
  end

  # remember a user in the database for user in persistent sessions
  def remember
  	self.remember_token = User.new_token
  	update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_mail_delay_job
    NotifyDelayJobEmail.set(wait: 2.minutes).perform_later(self)
  end

  def activate
    update_attributes activated: true, activated_at: Time.zone.now
  end

  def forget
  	update_attribute(:remember_digest, nil)
  end

  def shipper?
    self.role == Settings.user_type.shipper
  end

  def admin?
    self.role == Settings.user_type.admin
  end

  def customer?
    self.role == Settings.user_type.customer
  end


  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end

end
