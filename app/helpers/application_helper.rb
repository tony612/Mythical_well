module ApplicationHelper
  def own?(obj)
    return false if obj.blank?
    user_signed_in? and current_user == obj.user
  end
end
