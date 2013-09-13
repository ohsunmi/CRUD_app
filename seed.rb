require 'pg'
require 'faker'

conn = PG.connect(:dbname => 'crud_app', :host => 'localhost')

10.times do 
	name = Faker::Name.name.gsub("'", "")

	sql = "INSERT INTO artists (name, genre, members, origin, soundcloud_followers) VALUES ('#{name}') RETURNING id;"

	conn.exec(sql)
end