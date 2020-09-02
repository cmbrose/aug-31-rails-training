require "application_system_test_case"

class MovieTest < ActiveSupport::TestCase
  test "movie has a title" do
    movie = Movie.new(title: 'Parasite', director: 'Bong Joon-ho')

    assert_equal movie.title, 'Parasite'
    assert_equal movie.director, 'Bong Joon-ho'
    assert movie.valid?
  end

  test "movie is invalid without a title" do
    movie = Movie.new(title: nil, director: 'Bong Joon-ho')

    refute movie.valid?
  end

  test "returns the number of movies in the database with more than a given number of Facebook likes" do
    (0..9).each { |id| Movie.create(title: "movie#{id}", facebook_likes: id) }

    count = Movie.count_with_more_facebook_likes(2)
    assert_equal count, 7
  end

  test "returns a list of all movie titles" do
    Movie.create(title: 'movie1')
    Movie.create(title: 'movie2')
    Movie.create(title: 'movie3')

    titles = Movie.titles

    assert_equal titles, ['movie1','movie2','movie3']
  end

  test "returns all movies by a director that were made after the year 2010" do
    expected = []

    expected << Movie.create(title: 'movie1', director: 'director1', year: 2011)
    expected << Movie.create(title: 'movie2', director: 'director1', year: 2020)

    Movie.create(title: 'movie3', director: 'director1', year: 2009)

    Movie.create(title: 'movie4', director: 'director2', year: 2011)

    movies = Movie.directed_by_after('director1', 2010)

    assert_equal movies, expected
  end

  test "returns all movies in order of most to least facebook likes" do
    movie1 = Movie.create(title: 'movie1', facebook_likes: 10)
    movie2 = Movie.create(title: 'movie2', facebook_likes: 2)
    movie3 = Movie.create(title: 'movie3', facebook_likes: 50)
    movie4 = Movie.create(title: 'movie4', facebook_likes: 1)
    movie5 = Movie.create(title: 'movie5', facebook_likes: 15)

    expected = [movie3, movie5, movie1, movie2, movie4]

    movies = Movie.order_by_facebook_likes

    assert_equal movies, expected
  end

  test "can find a movie by its title, and tell you what year it was released" do
    expected = '2020'
    
    Movie.create(title: 'movie1', year: '2010')
    Movie.create(title: 'movie2', year: '2009')
    Movie.create(title: 'target', year: expected)
    Movie.create(title: 'movie3', year: '2001')

    year = Movie.get_release_year_of_movie('target')

    assert_equal year, expected
  end

  test "can find a movie by its title, and tell you what year it was released, but doesn't explode if not found" do   
    Movie.create(title: 'movie1', year: '2010')
    Movie.create(title: 'movie2', year: '2009')
    Movie.create(title: 'movie3', year: '2001')

    year = Movie.get_release_year_of_movie('target')

    assert_nil year
  end
end
