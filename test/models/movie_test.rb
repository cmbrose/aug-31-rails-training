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
end
