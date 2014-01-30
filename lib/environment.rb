require_relative 'database'
require_relative '../models/client'
require_relative '../models/appointment'
require 'logger'

class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.database_connection
    Database.connection(@@environment)
  end

  def self.logger
    @@logger ||= Logger.new("logs/#{@@environment}.log")
  end
end
