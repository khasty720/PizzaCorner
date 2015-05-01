module ApplicationHelper

  #--- Check if user is the Admin ---
  def is_admin
    if @admin == current_user
      return true
    else
      return false
    end
  end
  #----------------------------------

  #--- Check if user is the Admin ---
  def is_employee
    if current_user.employee == true
      return true
    else
      return false
    end
  end
  #----------------------------------



end
