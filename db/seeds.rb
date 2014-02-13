actors = {"Clint Eastwood" => 190, "Gene Hackman" => 193, "Morgan Freeman" => 192, "Milla Jovavich" => 63, "Johnny Depp" => 85 }
actors2 = {"Lucy Liu" => 140, "Hank Azaria" => 5587, "Albert Brooks" => 13, "Bruce Willis" => 62, "Johnny Depp" => 85 }

movies = ["Finding Nemo", "Paths Of Glory", "Gravity", "Rashomon", "The Shawshank Redemption"]
movies2 = ["The Apartment", "The Godfather", "Seven Samurai", "Solaris", "Dallas Buyers Club", "Dragnet"]

id = [12, 975, 49047, 548, 278]
id2 = [284, 238, 346, 593, 152532, 10023]
year = [2003, 1957, 2013, 1950, 1994]
year2 = [1960, 1972, 1954, 1972, 2013, 1987]

movies.each_with_index {|x, ind| Movie.create(id: id[ind], title: x, actors: actors, year: year[ind]) }
movies2.each_with_index {|x, ind| Movie.create(id: id2[ind], title: x, actors: actors2, year: year2[ind]) }
