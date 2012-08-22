module PathsHelpers
  def path_to(page_name)
    case page_name

    when /the home page/
      root_path

    else
      if path = match_rails_path_for(page_name)
        path
      else
        raise "Can't find mapping from \"#{page_name}\" to a path."
      end
    end
  end

  def match_rails_path_for(page_name)
    if page_name.match(/the (first|last) (.+) page/)
      model = eval($2.capitalize)
      model_instance = model.send("#{$1}")
      send("#{$2}_path", model_instance)
    elsif page_name.match(/the (.+) page/)
      send("#{$1.gsub(' ', '_')}_path") rescue nil
    end
  end
end

World(PathsHelpers)
