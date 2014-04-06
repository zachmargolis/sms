require 'sequel'


Sequel.extension :pagination

module Models
end

$:.unshift(File.dirname(__FILE__))

require 'models/attachment'
require 'models/chat'
require 'models/handle'
require 'models/message'