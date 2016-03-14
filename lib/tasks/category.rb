class Category
  # this is a DataMapper model...
  include DataMapper::Resource
  property :id, Serial
  property :name, String

  has n, :categorizations

  def tasks
    self.categorizations.map(&:tasks).flatten.uniq
  end
end
