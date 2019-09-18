# frozen_string_literal: true

require_relative "input/the_atlantic.rb"

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

save "the_atlantic.xml", TheAtlantic.new.feed
