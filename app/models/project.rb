class Project < ActiveRecord::Base
  attr_accessible :name, :about, :url, :bitcoin_address
end
