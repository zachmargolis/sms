require 'sequel'
require 'logger'

class Database
  attr_reader :db, :logger

  def initialize(sqlite_file, log = true)
    @logger = log && Logger.new(STDOUT)
    @db = Sequel.connect("sqlite://#{sqlite_file}", logger: logger)
  end
end