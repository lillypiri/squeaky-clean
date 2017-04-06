require 'csv'

# @@ Variables that start with @@ are shared between all instances. Whenever it changes, it changes for all of them.
class Table
  @@next_id = 1
  @@filename = nil

  def initialize (filename)
    @filename = filename
    # here map is iterating over each row and instead of returning it as an object it returns it as an integer. (its id)
    @@next_id = (all.map{ |row| row.id }.max || 0) + 1
end

# table.create is now a method. props[:id] is now next_id
def create (props)
  # this gives props an ever incrementing id -- see def next_id
  props[:id] = next_id
  # makes a new row by giving it the props hash
  row = Row.new(props)
  # a+ means if the file doesn't it exist, it will create it and open it for writing.
  # << push new value onto array
  CSV.open(@filename, "a+") do |csv|
    csv << row.to_csv
  end

  row
end


def all
  # readlines converts the file to an array. |line| is creating a new row with the arguments in the line below it.
  CSV.open(@filename, "a+").readlines.map do |line|
    Row.new id: line[0], name: line[1], hat: line[2]
  end
end

# finds the first row with the given id and then returns it.
def find (id)
  all.find{ |row| row.id == id }
end


  def next_id
    id = @@next_id
    @@next_id += 1

    id
  end
end

class Row
  attr_reader :id
  attr_accessor :name, :hat

  def initialize (args)
    @id = args[:id].to_i
    @name = args[:name]
    @hat = args[:hat]
  end

  def to_csv
    [@id, @name, @hat]
  end

  def to_s
    "#{@name} (ID #{@id}) wears a #{@hat} hat."
  end
end
#
# table = Table.new('./test.csv')
# table.create name: 'Nathan', hat: 'cowboy'
#
# puts table.find(1)
