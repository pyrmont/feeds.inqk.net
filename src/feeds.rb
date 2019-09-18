# frozen_string_literal: true

require_relative "input/the_atlantic.rb"
require_relative "input/new_yorker.rb"

Timeliness.add_formats(:date, "mmm d, yy")

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

save "the_atlantic.xml", TheAtlantic.new.feed
save "new_yorker.xml", NewYorker.new.feed
