# frozen_string_literal: true

require "optparse"
require "timeliness"

Timeliness.add_formats(:date, "mmm d, yy")

def options
  return @options unless @options.nil?

  @options = {
    includes: [],
    excludes: [],
    rules_dir: "rules",
    output_dir: "outputs"
  }

  OptionParser.new do |parser|
    parser.banner = <<~MSG
      Usage: feeds.rb [options]

      Fetches and parses feeds specified in rules files and writes the outputs
      to the outputs directory.

      Feeds are parsed in accordance with specified rules files. If no rules
      files are specified, the script will use all files in the rules
      directory.
    MSG
    parser.separator ""
    parser.separator "Specific options:"

    parser.on("-i", "--include FILE", "Include rules in FILE.") do |name|
      @options[:includes].push name
    end

    parser.on("-e", "--exclude FILE", "Exclude rules in FILE.") do |name|
      @options[:excludes].push name
    end

    parser.on("-o", "--output-dir DIR", "Use DIR to save outputs. Default: 'outputs'") do |dir|
      @options[:output_dir] = dir
    end

    parser.on("-r", "--rules-dir DIR", "Use DIR as source for rules. Default: 'rules'") do |dir|
      @options[:rules_dir] = dir
    end

    parser.on_tail("-h", "--help", "Show this message") do
      puts parser
      exit
    end
  end.parse!

  @options
end

def save(name, contents)
  File.write(name, contents)
end

def file_names(options)
  return options[:includes] unless options[:includes].empty?

  rules_dir = options[:rules_dir]
  all = Dir.each_child(rules_dir).map { |name| [rules_dir, name].join("/") }

  if options[:excludes].empty?
    all
  else
    all.reject { |name| options[:excludes].include? name }
  end
end

file_names(options).each do |file_name|
  require_relative file_name
  base_name = file_name.split("/").last.delete_suffix(".rb")
  class_name = base_name
    .split('_')
    .map(&:capitalize)
    .join
  klass = Object.const_get class_name
  begin
    save "#{options[:output_dir]}/#{base_name}.xml", klass.new.feed
  rescue => e
    puts "Failed to parse rules in #{file_name}"
    puts e.message
  end
end
