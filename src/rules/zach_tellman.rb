# frozen_string_literal: true

require "feedstock"

class ZachTellman
  def feed
    url = "https://ideolalia.com/essays.html"

    link = Feedstock::Extract.new(
      selector: "a",
      content: { attribute: "href" },
      prefix: "https://ideolalia.com"
    )

    info = { id: url,
             updated: last_modified(url),
             title: "Zach Tellman: Essays",
             author: "Zach Tellman" }

    entry = { id: link,
              updated: last_modified(url),
              title: Feedstock::Extract.new(selector: "a"),
              author: "Zach Tellman",
              link: link,
              summary: "An essay by Zach Tellman." }

    entries = Feedstock::Extract.new(selector: "ul.posts > li")

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules
  end

  private def last_modified(url)
    return @last_modified unless @last_modified.nil?

    URI.open(url) do |f|
      @last_modified = f.meta["last-modified"]
    end
  end
end
