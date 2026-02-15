# frozen_string_literal: true

require "feedstock"

class BackToBackBarries
  def feed
    url = "https://www.theguardian.com/australia-news/series/full-story/podcast.xml"

    info = { title: "Back to Back Barries",
             link: "https://www.theguardian.com/australia-news/series/full-story",
             description: "Barry Cassidy and Tony Barry break down big political questions.",
             language: Feedstock::Extract.new(selector: "language"),
             copyright: Feedstock::Extract.new(selector: "copyright"),
             lastBuildDate: Feedstock::Extract.new(selector: "lastBuildDate"),
             itunes_author: "Guardian Australia",
             itunes_category: Feedstock::Extract.new(selector: "itunes|category", content: { attribute: "text" }),
             itunes_image: "https://is1-ssl.mzstatic.com/image/thumb/Podcasts126/v4/cf/fc/4a/cffc4a90-7944-7dec-5f40-94740811347e/mza_6801865328765384357.jpg/1200x1200bf-60.jpg" }

    entry = { title: Feedstock::Extract.new(selector: "title"),
              description: Feedstock::Extract.new(selector: "description", prefix: "<![CDATA[", suffix: "]]>"),
              enclosure: Feedstock::Extract.new(selector: "enclosure", content: "xml"),
              pubDate: Feedstock::Extract.new(selector: "pubDate"),
              guid: Feedstock::Extract.new(selector: "guid"),
              itunes_author: "Guardian Australia",
              itunes_duration: Feedstock::Extract.new(selector: "itunes|duration"),
              itunes_image: Feedstock::Extract.new(selector: "itunes|image", content: { attribute: "href" })}

    entries = Feedstock::Extract.new(selector: "item", filter: lambda { |entry| keep? entry })

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules, :xml, "podcast.xml"
  end

  def keep?(entry)
    return true if entry["title"].include?("Back to Back Barries")
    return false
  end
end
