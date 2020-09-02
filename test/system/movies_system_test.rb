require "application_system_test_case"

class MoviesSystemTest < ApplicationSystemTestCase
  test "visiting the show" do
    movie = Movie.create(title: 'Parasite', director: 'Bong Joon-ho')

    visit "/movies/#{movie.id}"
    assert_text "Parasite"
    assert_text "Bong Joon-ho"
  end

  test "visiting for another movie" do
    Movie.create(title: 'Parasite', director: 'Bong Joon-ho')
    movie = Movie.create(title: 'Titanic', director: 'James Cameron')

    visit "/movies/#{movie.id}"
    assert_text "Titanic"
    assert_text "James Cameron"
  end

  test "visiting the index" do
    Movie.create(title: 'Movie1', director: 'Director1')
    Movie.create(title: 'Movie2', director: 'Director2')
    Movie.create(title: 'Movie3', director: 'Director3')

    visit "/movies"

    assert_text "Movie1"
    assert_text "Director1"

    assert_text "Movie2"
    assert_text "Director2"

    assert_text "Movie3"
    assert_text "Director3"
  end

  test "creating a new movie" do
    visit "/movies"

    assert_button "Add New Movie"
    click_button "Add New Movie"

    assert_current_path "/movies/new"
    assert_selector ".new_movie"

    fill_in :movie_title, with: 'Movie1'
    fill_in :movie_director, with: 'Director1'
    fill_in :movie_year, with: '2020'

    click_on "Add New Movie"

    assert_text 'Movie1'
    assert_text 'Director1'
    assert_text '2020'
  end

  test "edit a movie" do
    movie = Movie.create(title: 'Movie1', director: 'Director1', year: 'Year2')

    visit "/movies/#{movie.id}"

    edit_text = "Edit #{movie.title}"
    assert_button edit_text
    click_button edit_text

    assert_current_path "/movies/#{movie.id}/edit"
    assert_selector ".edit_movie"

    fill_in :movie_title, with: 'Movie2'
    fill_in :movie_director, with: 'Director2'
    fill_in :movie_year, with: 'Year2'

    click_on "Edit Movie"

    assert_no_text 'Movie1'
    assert_no_text 'Director1'
    assert_no_text 'Year1'

    assert_text 'Movie2'
    assert_text 'Director2'
    assert_text 'Year2'
  end
end
