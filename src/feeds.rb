# frozen_string_literal: true

require "timeliness"

Timeliness.add_formats(:date, "mmm d, yy")

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

def file_names
  return Dir.each_child("input") if ARGV.empty?
  return ARGV.each unless ARGV[0] == "-e"

  excluded = ARGV.slice(1..-1)
  Dir.each_child("input").reject { |fn| excluded.include? fn }
end

file_names.each do |file_name|
  require_relative "input/#{file_name}"
  base_name = file_name.delete_suffix(".rb")
  class_name = base_name
    .split('_')
    .map(&:capitalize)
    .join
  klass = Object.const_get class_name
  save "#{base_name}.xml", klass.new.feed
end
