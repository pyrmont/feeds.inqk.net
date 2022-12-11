# frozen_string_literal: true

require "feedstock"

class NhkRadioNewsJ
  def feed
    url = "https://www.nhk.or.jp/s-media/news/podcast/list/v1/all.xml"

    info = { title: "NHK Radio News (Japanese)",
             link: "https://www.nhk.or.jp/radionews/",
             description: Feedstock::Extract.new(selector: "description"),
             language: Feedstock::Extract.new(selector: "language"),
             copyright: Feedstock::Extract.new(selector: "copyright"),
             lastBuildDate: Feedstock::Extract.new(selector: "lastBuildDate"),
             itunes_author: Feedstock::Extract.new(selector: "itunes|author"),
             itunes_category: Feedstock::Extract.new(selector: "itunes|category", content: { attribute: "text" }),
             itunes_image: Feedstock::Extract.new(selector: "itunes|image", content: { attribute: "href" }),
             itunes_keywords: Feedstock::Extract.new(selector: "itunes|keywords") }

    entry = { title: Feedstock::Extract.new(selector: "title"),
              description: "The 7 o'clock news.",
              enclosure: Feedstock::Extract.new(selector: "enclosure", content: "xml"),
              pubDate: Feedstock::Extract.new(selector: "pubDate"),
              guid: Feedstock::Extract.new(selector: "guid"),
              itunes_author: Feedstock::Extract.new(selector: "itunes|author"),
              itunes_duration: Feedstock::Extract.new(selector: "itunes|duration") }

    entries = Feedstock::Extract.new(selector: "item", filter: lambda { |entry| keep? entry })

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules, :xml, "podcast.xml"
  end

  def keep?(entry)
    entry["title"].include? "午前７"
  end
end
