# frozen_string_literal: true

require "feedstock"

class NhkRadioNewsJ
  def feed
    url = "https://www.nhk.or.jp/s-media/news/podcast/list/v1/all.xml"

    info = { title: { literal: "NHK Radio News (Japanese)" },
             link: { literal: "https://www.nhk.or.jp/radionews/" },
             description: "description",
             language: "language",
             copyright: "copyright",
             lastBuildDate: "lastBuildDate",
             itunes_author: "itunes|author",
             itunes_category: { path: "itunes|category",
                                content: { attribute: "text" } },
             itunes_image: { path: "itunes|image",
                             content: { attribute: "href" } },
             itunes_keywords: "itunes|keywords" }

    entries = { path: "item",
                filter: lambda { |entry| keep? entry } }

    entry = { title: "title",
              description: { literal: "The 7 o'clock news." },
              enclosure: { path: "enclosure",
                           content: "xml",
                           processor: lambda { |xml, rule| https xml } },
              pubDate: "pubDate",
              guid: "guid",
              itunes_author: "itunes|author",
              itunes_duration: "itunes|duration" }

    rules = { info: info, entries: entries, entry: entry }

    Feedstock.feed url, rules, :xml, "podcast.xml"
  end

  def https(xml)
    xml.gsub "http://", "https://"
  end

  def keep?(entry)
    entry["title"].include? "午前７"
  end
end
