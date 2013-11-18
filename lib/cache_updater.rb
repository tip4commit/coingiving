class CacheUpdater
  def self.work_forever
    while true do
      self.work
    end
  end

  def self.work
    AaLogger.info "Updating sponsors donations cache..."
    Sponsor.update_donations_cache

    AaLogger.info "Updating projects donations cache..."
    Project.update_donations_cache

    AaLogger.info "Updating donation addresses donations cache..."
    DepositAddress.update_donations_cache
  end

end