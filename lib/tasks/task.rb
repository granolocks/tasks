class Task
  # this is a DataMapper model...
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :complete, Boolean, default: false
end
