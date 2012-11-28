module ApplicationHelper
  def own?(obj)
    return false if obj.blank?
    user_signed_in? and current_user == obj.user
  end

  def link_to_current(*params)
    link_to_unless_current(*params) do
      link_to *params, :class => 'active'
    end
  end

end
