# frozen_string_literal: true

require "feedstock"

class SixColors
  def feed
    url = "https://sixcolors.com/feed/"

    info = { title: "Six Colors",
             link: "https://sixcolors.com/feed",
             description: Feedstock::Extract.new(selector: "description"),
             language: Feedstock::Extract.new(selector: "language"),
             lastBuildDate: Feedstock::Extract.new(selector: "lastBuildDate") }

    entry = { title: Feedstock::Extract.new(selector: "title"),
              description: Feedstock::Extract.new(selector: "description", type: "cdata"),
              pubDate: Feedstock::Extract.new(selector: "pubDate"),
              author: Feedstock::Extract.new(selector: "dc|creator"),
              guid: Feedstock::Extract.new(selector: "guid"),
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
