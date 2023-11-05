module ApplicationHelper
    def display_stars(rating)
      return unless rating # Add a check for nil
      
      content_tag(:span, "★" * rating, class: "star-rating")
    end
  end