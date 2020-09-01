class Movie < ApplicationRecord
    # validates :title, presence: true
    validates_presence_of :title
end