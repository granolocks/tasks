class Task
  # this is a DataMapper model...
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :priority, Integer, default: 0
  property :complete, Boolean, default: false

  validates_presence_of :title

  def complete!
    self.complete = true
    self.save
  end

  def printable(status=false)
    out = "id(#{id}), "
    out += "status(#{ complete ? 'done' : 'open'}), " if status
    out += "priority(#{priority}) #{title}"
    out
  end

  def full_printable(status)
    out = "title: #{title}\n"
    out += "  id: #{id}\n"
    out += "  status: #{ complete ? 'done' : 'open'})\n" if status
    out += "  priority: #{priority}\n"
    out += "  description: #{description}\n" if description
    out += "\n"
    out
  end
end
