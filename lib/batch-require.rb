require_relative "batch-require-helper"

class BatchRequire

  def initialize *gems

    gem_list_local , gem_list_server = `gem list -l`.split("\n") , internet_connection? ? `gem list -r`.split("\n") : []
    gem_list_local , gem_list_server = require_list_modify(gem_list_local) , require_list_modify(gem_list_server)
    gem_list_inbuilt = require_inbuilt_modify(Dir.entries(inbuilt_path()).keep_if { |inbuilt| (inbuilt.end_with? ".rb")})
    all_gems = (gem_list_local + gem_list_server + gem_list_inbuilt).uniq

    gems.each do |each_gem|
      if all_gems.include? each_gem
        if gem_list_local.include? each_gem
          require "#{each_gem}"
        elsif gem_list_inbuilt.include? each_gem
          require "#{each_gem}"
        elsif gem_list_server.include? each_gem 
          if internet_connection?
            `gem install #{each_gem}`
            require "#{each_gem}"
          else
            puts "#{each_gem} gem couldn't be downloaded due to no internet connection"
          end        
        end
      else
        puts "Invalid gem : #{each_gem}."
      end  
    end

  end 

end