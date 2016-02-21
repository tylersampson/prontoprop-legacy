<%- module_namespacing do -%>
  <%- if parent_class_name.present? -%>
class <%= class_name %>Decorator < ApplicationDecorator
  <%- else -%>
class <%= class_name %>
  <%- end -%>
  delegate_all


end
<% end -%>