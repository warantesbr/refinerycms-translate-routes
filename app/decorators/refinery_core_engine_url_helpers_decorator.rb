# We have to define a method missing handler for Refinery::Core::Engine.routes.url_helpers so the paths and urls are searched with the I18n.locale info
Refinery::Core::Engine.routes.url_helpers.class.send :define_method, :method_missing do |method_name, *args|

  new_method_name = method_name.to_s.gsub(/_path$/, "_#{I18n.locale}_path")
  new_method_name.gsub!(/_url$/, "_#{I18n.locale}_url")
  new_method_name = new_method_name.to_sym

  if method_name == new_method_name
    super method_name, args
  else
    # If there are no params we must avoid to pass it as a param or the translated helper will look for the route with empty format appending a '.'
    args.blank? ? Refinery::Core::Engine.routes.url_helpers.send(new_method_name.to_sym) : Refinery::Core::Engine.routes.url_helpers.send(new_method_name.to_sym, args)
  end

end