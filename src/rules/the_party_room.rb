# frozen_string_literal: true

require "feedstock"

class ThePartyRoom
  def feed
    url = "https://www.abc.net.au/feeds/7288214/podcast.xml"

    info = { title: "The Party Room",
             link: "https://www.abc.net.au/listen/programs/politics-now/",
             description: "Want to know what's really going on in Parliament House? Fran Kelly and Patricia Karvelas give you the political analysis that matters and explain what it means for you.",
             language: Feedstock::Extract.new(selector: "language"),
             copyright: Feedstock::Extract.new(selector: "copyright"),
             lastBuildDate: Feedstock::Extract.new(selector: "lastBuildDate"),
             itunes_author: "Australian Broadcasting Corporation",
             itunes_category: Feedstock::Extract.new(selector: "itunes|category", content: { attribute: "text" }),
             itunes_image: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts126/v4/cf/fc/4a/cffc4a90-7944-7dec-5f40-94740811347e/mza_6801865328765384357.jpg/1200x1200bf-60.jpg",
             itunes_keywords: Feedstock::Extract.new(selector: "itunes|keywords") }

    entry = { title: Feedstock::Extract.new(selector: "title"),
              description: Feedstock::Extract.new(selector: "description", prefix: "<![CDATA[", suffix: "]]>"),
              enclosure: Feedstock::Extract.new(selector: "enclosure", content: "xml"),
              pubDate: Feedstock::Extract.new(selector: "pubDate"),
              guid: Feedstock::Extract.new(selector: "guid"),
              itunes_author: "Australian Broadcasting Corporation",
              itunes_duration: Feedstock::Extract.new(selector: "itunes|duration"),
              itunes_image: Feedstock::Extract.new(selector: "itunes|image", content: { attribute: "href" })}

    entries = Feedstock::Extract.new(selector: "item", filter: lambda { |entry| keep? entry })

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules, :xml, "podcast.xml"
  end

  def keep?(entry)
    entry["title"].gsub!(" || The Party Room", "")
    image = entry["itunes_image"].dup
    entry.delete("itunes_image")
    return true if image.include?("6ddbbf2e265eb58a2ae6078c700660d7")
    return false
  end
end
