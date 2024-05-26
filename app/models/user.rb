class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :name, presence: true

  has_many :stocks
  has_many :stock_tags, dependent: :destroy
  has_many :tags, through: :stock_tags
  has_many :baskets
  has_many :user_groups, dependent: :destroy
  has_many :families, through: :user_groups

  def self.guest
    find_or_create_by!(name: 'ゲスト', email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
