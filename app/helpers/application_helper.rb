module ApplicationHelper
  def flash_class(level)
    case level
    when 'notice'
      'success'
    when 'alert'
      'danger'
    end
  end
end
