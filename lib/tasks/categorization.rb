class Categorization
  # this is a DataMapper model...
  include DataMapper::Resource

  property :id, Serial

  belongs_to :category
  belongs_to :task
end
