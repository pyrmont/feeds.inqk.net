# frozen_string_literal: true

require "feedstock"

class SixColors
  def feed
    url = "https://sixcolors.com/feed/"

    info = { id: url,
             updated: Feedstock::Extract.new(selector: "lastBuildDate"),
             title: "Six Colors",
             subtitle: Feedstock::Extract.new(selector: "description") }

    entry = { id: Feedstock::Extract.new(selector: "guid"),
              updated: Feedstock::Extract.new(selector: "pubDate"),
              title: Feedstock::Extract.new(selector: "title"),
              author: Feedstock::Extract.new(selector: "dc|creator"),
              link: Feedstock::Extract.new(selector: "link"),
              content: Feedstock::Extract.new(selector: "content|encoded", type: "cdata") }

    entries = Feedstock::Extract.new(selector: "item", filter: lambda { |entry| keep? entry })

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules, format = :xml
  end

  def keep?(entry)
    !entry["title"].include?("(Podcast)") &&
    !entry["title"].include?("(Sponsor)")
  end
end
