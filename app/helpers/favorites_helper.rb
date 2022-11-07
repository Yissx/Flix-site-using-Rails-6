module FavoritesHelper
    def like_or_dislike_button(favorite, movie)
        if favorite
            button_to "♡ Dislike", movie_favorite_path(movie, favorite), method: :delete 
        else
            button_to "♥️ Like", movie_favorites_path(movie) 
        end 
    end
end
