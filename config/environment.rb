# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MythicalWell::Application.initialize!

#ActionView::Base.field_error_proc = Proc.new do |html_tag, instance|
#  p "=====================Html tag instance"
#  p html_tag, instance.error_message
#  errors = Array(instance.error_message).join(',')
#  if html_tag.match('label')
#    html_tag = html_tag.gsub(/for=\".*\"/, "for=\"inputError\"").html_safe
#  else
#    %(#{html_tag}<span class="help-inline">#{errors}</span>).html_safe
#  end
#end
