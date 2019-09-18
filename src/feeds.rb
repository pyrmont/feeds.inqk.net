# frozen_string_literal: true

require_relative "input/longform_tb.rb"
require_relative "input/new_yorker.rb"
require_relative "input/the_atlantic.rb"

Timeliness.add_formats(:date, "mmm d, yy")

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

save "longform_tb.xml", Longform_TB.new.feed
save "new_yorker.xml", NewYorker.new.feed
save "the_atlantic.xml", TheAtlantic.new.feed
