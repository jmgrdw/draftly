module ApplicationHelper
  
  def format_salary(number)
    number_to_currency(number, :precision => 0)
  end
end
