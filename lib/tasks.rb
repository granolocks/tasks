
require 'data_mapper'
require 'dm-timestamps'
require 'dm-validations'

$:.unshift(File.dirname(__FILE__))

DataMapper::Property::String.length(255)
DataMapper.setup(:default, "sqlite:tasks.db")

require 'tasks/task'

DataMapper.auto_upgrade!
DataMapper.finalize

require 'pry'
binding.pry

