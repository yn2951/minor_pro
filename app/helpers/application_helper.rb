module ApplicationHelper
  def categorize(value, title)
    link_to title, {:category => value, :category_title => title}
  end

  def genrize(value, title)
    link_to title, {:genre => value, :genre_title => title, :category => @category, :category_title => @category_title}
  end

  def sortable(column, direction, sort_title)
    link_to sort_title, {:sort => column, :direction => direction, :sort_title => sort_title, :category => @category, :category_title => @category_title, :genre => @genre, :genre_title => @genre_title, :keyword => @keyword}
  end
end
