# frozen_string_literal: true

require "feedstock"

class ZachTellman
  def feed
    url = "https://ideolalia.com/essays.html"

    link = { path: "a",
             content: { attribute: "href" },
             prepend: "https://ideolalia.com" }

    info = { id: { literal: url },
             updated: { literal: last_modified(url) },
             title: { literal: "Zach Tellman: Essays" },
             author: { literal: "Zach Tellman" } }

    entries = "ul.posts > li"

    entry = { id: link,
              updated: { literal: last_modified(url) },
              title: "a",
              author: { literal: "Zach Tellman" },
              link: link,
              summary: { literal: "An essay by Zach Tellman." } }

    rules = { info: info, entries: entries, entry: entry }

    Feedstock.feed url, rules
  end

  private def last_modified(url)
    return @last_modified unless @last_modified.nil?

    URI.open(url) do |f|
      @last_modified = f.meta["last-modified"]
    end
  end
end
