module ApplicationHelper

  def render_need_row_no(number)
    number.analyzes.count * 3
  end

end
