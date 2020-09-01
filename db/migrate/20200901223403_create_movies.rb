class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :director
      t.string :year
      t.string :plot_keywords
      t.integer :facebook_likes
    end
  end
end
