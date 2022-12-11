# frozen_string_literal: true

require "feedstock"

class Compact
  def feed
    url = "https://compactmag.com"

    date = Feedstock::Extract.new(
      selector: "div.published",
      type: "datetime"
    )

    link = Feedstock::Extract.new(
      selector: "",
      content: { attribute: "href" },
      prefix: "https://compactmag.com"
    )

    info = { id: url,
             updated: date,
             title: "Compact",
             author: "Compact Magazine" }

    entry = { id: link,
              updated: date,
              title: Feedstock::Extract.new(selector: "div.title > h3"),
              author: Feedstock::Extract.new(selector: "div.title > h4"),
              link: link,
              summary: "An article in Compact." }

    entries = Feedstock::Extract.new(selector: "div.articles-list > a.article")

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules
  end
end
