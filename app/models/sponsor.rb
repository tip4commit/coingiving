class Sponsor < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true
  validates :url, url: true

  has_many :deposit_addresses
  has_many :deposits, :through => :deposit_addresses
  has_many :projects, :through => :deposit_addresses

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
