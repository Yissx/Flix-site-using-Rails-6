module ApplicationHelper
    def image_as_link_or_not
        if current_user_admin?
            link_to image_tag('logo.png'), genres_path
        else
            link_to image_tag('logo.png'), movies_path
        end
    end
end
