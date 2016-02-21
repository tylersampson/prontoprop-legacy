module ApplicationHelper
  
  def is_active_controller(controller_name)
    if controller_name.kind_of? Array
      controller_name.include?(params[:controller]) ? "active open" : nil
    else
      params[:controller] == controller_name ? "active" : nil
    end      
  end
  
  def avatar_url(email, size = nil)
    if email.present?
      gravatar_id = Digest::MD5.hexdigest(email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
    end
  end

  def flash_messages
    messages = []
    flash.each do |type, message|
      type = 'success' if type == 'notice'
      type = 'error'   if type == 'alert'
      text = "<script>toastr.#{type}('#{message}');</script>"
      messages << text.html_safe if message
    end
    messages.join("\n").html_safe
  end

  def link_to_new_window(name, path)
    link_to(icon('link', name), path, target: '_blank', class: 'ext-link')
  end

  def options_for_selectize(values, name = :name, key = :id)
    values = [values].compact if !values.kind_of?(ActiveRecord::Relation)
    options_for_select(values.map{ |v| [v.try(name), v.try(key), { 'data-data' => v.to_json }] }, selected: values.collect(&key))
  end
  
  def link_to_add_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields", data: {id: id, fields: fields.gsub("\n", "")})
  end
  
  def nested_fields_template(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    fields.gsub("\n", "")
  end
end