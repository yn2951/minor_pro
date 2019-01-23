module ApplicationHelper
  def sortable(column, direction, title)
    link_to title, {:sort => column, :direction => direction, :title => title, :keyword => @keyword}
  end
end
