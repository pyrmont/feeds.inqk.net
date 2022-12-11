# frozen_string_literal: true

require "feedstock"

class TheAtlantic
  def feed
    url = "https://www.theatlantic.com/magazine/"

    date = Feedstock::Extract.new(
      selector: "main h1",
      absolute: true,
      prefix: "1 ",
      type: "datetime"
    )

    link = Feedstock::Extract.new(
      selector: "h3 > a",
      content: { attribute: "href" }
    )

    info = { id: url,
             updated: date,
             title: "The Atlantic",
             author: "The Atlantic Monthly Group" }

    entry = { id: link,
              updated: date,
              title: Feedstock::Extract.new(selector: "h3"),
              author: Feedstock::Extract.new(selector: "a[class*=_authorLink]"),
              link: link,
              summary: Feedstock::Extract.new(selector: "p") }

    entries = Feedstock::Extract.new(selector: "div[class*=Item_info]")

    rules = { info: info, entry: entry, entries: entries}

    Feedstock.feed url, rules
  end
end
