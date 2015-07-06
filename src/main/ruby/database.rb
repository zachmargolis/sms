require 'sequel'
require 'logger'

Sequel.extension :pagination

class Database
  attr_reader :db, :logger

  def initialize(sqlite_file, log = true, &block)
    @logger = log ? Logger.new(STDOUT) : nil
    @db = Sequel.connect("sqlite://#{sqlite_file}", logger: logger, &block)
  end
end