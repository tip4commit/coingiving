class Sponsor < ActiveRecord::Base
  include Concerns::DonationsCache
  
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
  has_many :projects, -> { where('deposit_addresses.year_donations > 0') }, :through => :deposit_addresses
  # todo fix to whole time donations ^^^

  scope :public_only, -> { where(:private_donations => false) }

  scope :confirmed, -> { where("confirmed_at is not ?", nil) }

  def to_param
    "#{id}-#{name.parameterize}"
  end

  def project_budget project_id
    deposit_address = deposit_addresses.find_by_project_id(project_id)
    if deposit_address.nil?
      0
    else
      deposit_address.update_donations_cache if deposit_address.year_donations.nil?
      deposit_address.year_donations
    end
  end

end
