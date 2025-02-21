# frozen_string_literal: true

require "feedstock"

class ThePartyRoom
  def feed
    url = "https://www.abc.net.au/feeds/7288214/podcast.xml"

    info = { title: "The Party Room",
             link: "https://www.abc.net.au/listen/programs/politics-now/",
             description: Feedstock::Extract.new(selector: "description"),
             language: Feedstock::Extract.new(selector: "language"),
             copyright: Feedstock::Extract.new(selector: "copyright"),
             lastBuildDate: Feedstock::Extract.new(selector: "lastBuildDate"),
             itunes_author: "Australian Broadcasting Corporation",
             itunes_category: Feedstock::Extract.new(selector: "itunes|category", content: { attribute: "text" }),
             itunes_image: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts126/v4/cf/fc/4a/cffc4a90-7944-7dec-5f40-94740811347e/mza_6801865328765384357.jpg/1200x1200bf-60.jpg",
             itunes_keywords: Feedstock::Extract.new(selector: "itunes|keywords") }

    entry = { title: Feedstock::Extract.new(selector: "title"),
              description: Feedstock::Extract.new(selector: "description"),
              enclosure: Feedstock::Extract.new(selector: "enclosure", content: "xml"),
              pubDate: Feedstock::Extract.new(selector: "pubDate"),
              guid: Feedstock::Extract.new(selector: "guid"),
              itunes_author: "Australian Broadcasting Corporation",
              itunes_duration: Feedstock::Extract.new(selector: "itunes|duration") }

    entries = Feedstock::Extract.new(selector: "item", filter: lambda { |entry| keep? entry })

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules, :xml, "podcast.xml"
  end

  def keep?(entry)
    og_title = entry["title"].dup
    entry["title"] = entry["title"].gsub!(" || The Party Room", "")
    og_title.include? "|| The Party Room"
  end
end
