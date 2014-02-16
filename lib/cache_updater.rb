class CacheUpdater
  def self.work_forever
    while true do
      self.work
      sleep 120
    end
  end

  def self.work
    Rails.logger.info "Updating sponsors donations cache..."
    Sponsor.update_donations_cache

    Rails.logger.info "Updating projects donations cache..."
    Project.update_donations_cache

    Rails.logger.info "Updating donation addresses donations cache..."
    DepositAddress.update_donations_cache
  end

end