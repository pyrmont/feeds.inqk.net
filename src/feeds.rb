# frozen_string_literal: true

require "timeliness"

Timeliness.add_formats(:date, "mmm d, yy")

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

def file_names
  all = Dir.each_child("input").map { |fn| fn.prepend "input/" }

  if ARGV.empty?
    all
  elsif ARGV[0] != "-e"
    ARGV.each
  else
    excluded = ARGV.slice(1..-1)
    all.reject { |fn| excluded.include? fn }
  end
end

file_names.each do |file_name|
  require_relative file_name
  base_name = file_name.split("/").last.delete_suffix(".rb")
  class_name = base_name
    .split('_')
    .map(&:capitalize)
    .join
  klass = Object.const_get class_name
  save "#{base_name}.xml", klass.new.feed
end
