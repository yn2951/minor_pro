module ApplicationHelper
  def categorize(category, category_title)
    link_to category_title, {:category => category, :category_title => category_title, :genre => @genre, :genre_title => @genre_title, :sort => @column, :direction => @direction, :sort_title => @sort_title, :keyword => @keyword}
  end

  def genrize(genre, genre_title)
    link_to genre_title, {:category => @category, :category_title => @category_title, :genre => genre, :genre_title => genre_title, :sort => @column, :direction => @direction, :sort_title => @sort_title, :keyword => @keyword}
  end

  def sortable(column, direction, sort_title)
    link_to sort_title, {:category => @category, :category_title => @category_title, :genre => @genre, :genre_title => @genre_title, :sort => column, :direction => direction, :sort_title => sort_title, :keyword => @keyword}
  end
end
