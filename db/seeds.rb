movies = [
    'Aquaman',
    'Bumblebee',
    'Avengers: Endgame'
]

seasons = [
    'Doom Patrol S01',
    'Brooklyn Nine-Nine S06',
    'Supernatural S14'
]

movies.each do |x|
  movie = Movie.create(title: x)
  movie.variants.create(quality: 'HD', price: rand(100))
  movie.variants.create(quality: 'SD', price: rand(100))
  movie.assets.create(title: "#{x} - Playable Asset")
end

seasons.each do |x|
  season = Season.create(title: x)
  season.variants.create(quality: 'HD', price: rand(100))
  season.variants.create(quality: 'SD', price: rand(100))
  10.times do |i|
    season.assets.create(title: "Episode #{i+1}", sequence_number: i+1)
  end
end

puts "Data has been imported!"

