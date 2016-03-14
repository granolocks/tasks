class Task
  # this is a DataMapper model...
  include DataMapper::Resource

  property :id, Serial
  property :title, String
  property :description, Text
  property :priority, Integer, default: 0
  property :complete, Boolean, default: false

  validates_presence_of :title

  has n, :categorizations

  def self.print_table(options)
    if options[:category]
      c = Category.all(name: options[:category])
      if c
        tasks = c.categorizations.map(&:task).flatten.uniq
        tasks.select{|x| !x.complete}
        status = false
      end
    elsif options[:all]
      tasks = Task.all.sort_by{|t|t.priority.to_i}.reverse
      status = true
    else
      tasks = Task.all(complete: false).sort_by{|t|t.priority}.reverse
      status = false
    end

    if tasks.count > 0
      t_attrs = tasks.map(&:full_attributes)

      lengths = t_attrs.each_with_object({}) do |attrs, coll|
        attrs.keys.each do |k|
          coll[k] ||= k.to_s.length
          l = attrs[k].to_s.length
          coll[k] = l if l > coll[k]
        end
      end

      keys = %w{ id priority title categories}.map(&:to_sym)

      header = " #{keys.map{|x| x.to_s.ljust(lengths[x])}.join(' | ')}"

      puts header
      puts "-" * header.length

      t_attrs.each do |attrs|
        data = keys.map{|x| attrs[x].to_s.ljust(lengths[x])}
        puts " #{data.join(' | ')}"
      end
    else
      puts "Nothing to do, go take a nap! ...zzzzz... "
    end
  end

  def full_attributes
    a = attributes
    a[:categories] = categories.join(', ')
    a
  end

  def categories
    categorizations.map(&:category).flatten.map(&:name)
  end

  def complete!
    self.complete = true
    self.save
  end

  def printable(status=false)
    out = "id(#{id}), "
    out += "status(#{ complete ? 'done' : 'open'}), " if status
    out += "categories(#{categories.join(',')}), "
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
