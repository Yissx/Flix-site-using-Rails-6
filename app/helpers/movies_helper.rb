module MoviesHelper
    def total_gross(movie)
        if movie.flop?
            "Flop!"
        else
            number_to_currency(movie.total_gross, precision: 0)
        end
    end
    def year_of(movie)
        if movie.released_on.blank?
            "No date information"
        else
            movie.released_on.year
        end
    end
    def reviews_and_link(movie)
        if movie.average_stars.zero?
            content_tag(:strong, "No reviews")
        else
            link_to pluralize(movie.reviews.size, 'review'), movie_reviews_path(movie)
        end
    end
    def nav_link_to(text, url)
        if current_page?(url)
          link_to(text, url, class: "active")
        else
          link_to(text, url)
        end
      end
end
