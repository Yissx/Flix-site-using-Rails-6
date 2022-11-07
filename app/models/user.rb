class User < ApplicationRecord

  before_save :format_username, :format_email, :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_movies, through: :favorites, source: :movie
  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 10, allow_blank: true }
  validates :nickname, presence: true, format: { with: /\A[A-Z0-9]+\z/i }, uniqueness: { case_sensitive: false }

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
  def format_username
    self.nickname = nickname.downcase
  end
  def format_email
    self.email = email.downcase
  end
  def to_param
    slug
  end

  private
  def set_slug
    self.slug = name.parameterize
  end
end
