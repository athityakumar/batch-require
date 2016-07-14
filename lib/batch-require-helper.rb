require 'open-uri'

def internet_connection?
  begin
    true if open("http://www.google.com/")
  rescue
    false
  end
end

def require_list_modify list

  for i in (0..list.count-1)
    list[i] = list[i].split("(")[0].gsub(" ","")
  end

  return list

end

def require_inbuilt_modify list

  for i in (0..list.count-1)
    list[i] = list[i].gsub(".rb","")
  end

  return list

end

def inbuilt_path 

  version = Dir.entries("/usr/lib/ruby")
  version.delete(".")
  version.delete("..")
  version.delete("vendor_ruby")
  version_used = version[0]

  return "/usr/lib/ruby/#{version_used}"

end 