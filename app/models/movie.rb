class Movie < ApplicationRecord
    # validates :title, presence: true
    validates_presence_of :title

    def self.count_with_more_facebook_likes threshold
        where("facebook_likes > ?", threshold).count
    end

    def self.titles
        # Movie.select(:title).map(&:title)
        pluck(:title)
    end

    def self.directed_by_after director, year
        where(director: director).where("year > ?", year)
    end

    def self.order_by_facebook_likes
        order(facebook_likes: :desc)
    end

    def self.get_release_year_of_movie title
        select(:title, :year).find_by(title: title)&.year
    end
end