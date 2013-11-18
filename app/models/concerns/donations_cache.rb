module Concerns::DonationsCache
  extend ActiveSupport::Concern

  included do
    def update_donations_cache
      update month_donations: deposits.where("deposits.created_at > ?", Time.now - 1.month).sum(:amount)
    end

    def self.update_donations_cache
      find_each do |obj|
        obj.update_donations_cache
      end
    end
  end
  
end