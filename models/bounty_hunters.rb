require('pg')
class Bounties

attr_reader 
attr_accessor :name, :species, :favourite_weapon, :bounty_value

def initialize(options)
  @name = options[:name]
  @species = options[:species]
  @favourite_weapon = options[:favourite_weapon]
  @bounty_value = options[:bounty_value]
  @id = options[:id].to_i if options[:id]
end

def save
  db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'})
  sql = "INSERT INTO space_cowboys
  (name, species, favourite_weapon, bounty_value)
  VALUES
  ('#{ @name }','#{@species}','#{@favourite_weapon}','#{@bounty_value}')
  RETURNING id;"
  @id = db.exec(sql)[0]['id'].to_i
  db.close
end

def update
  db = PG.connect( {dbname: 'space_cowboys', host:'localhost'})
    sql = "UPDATE space_cowboys SET (name, species, favourite_weapon, bounty_value) = ('#{@name}','#{@species}','#{@favourite_weapon}',#{@bounty_value}) WHERE id = '#{@id}';"
    db.exec(sql)
    db.close
end

def self.print
  db = PG.connect( {dbname: 'space_cowboys', host: 'localhost'})
  sql = "SELECT * FROM space_cowboys"
  db.exec(sql).each { |row| puts row}
  db.close
end

def self.delete_all
  db = PG.connect( {dbname: 'space_cowboys', host:'localhost'})
  sql = "DELETE FROM space_cowboys"
  db.exec(sql)
  db.close
end

def delete_row
  db = PG.connect( {dbname: 'space_cowboys', host:'localhost'})
  sql = "DELETE FROM space_cowboys WHERE id = '#{@id}';"
  db.exec(sql)
  db.close
end

def self.find_bounty(name)
  db = PG.connect( {dbname: 'space_cowboys', host:'localhost'})
  sql = "SELECT * FROM space_cowboys"
  result = db.exec(sql).select { |row| row['name'] == name }
  puts result
  db.close 
end

def self.all
  db = PG.connect( {dbname: 'space_cowboys', host:'localhost'})
  sql = "SELECT * FROM space_cowboys;"
  bounty_data = db.exec(sql)
  db.close
  return bounty_data.map { |bounty| Bounties.new(bounty) }
end


end