# frozen_string_literal: true

require "timeliness"

Timeliness.add_formats(:date, "mmm d, yy")

def save(name, contents)
  path = "../public/"
  File.write(path + name, contents)
end

file_names = if ARGV.empty?
               Dir.each_child("input")
             else
               ARGV.each
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
