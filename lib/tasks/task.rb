class Task
  # this is a DataMapper model...
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :priority, Text, default: 0
  property :complete, Boolean, default: false

  validates_presence_of :title

  def complete!
    self.complete = true
    self.save
  end
end
