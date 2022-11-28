# frozen_string_literal: true

require "feedstock"

class TheAtlantic
  def feed
    url = "https://www.theatlantic.com/magazine/"

    date = { path: "main h1",
             type: "datetime",
             prepend: "1 " }

    link = { path: "h3 > a",
             content: { attribute: "href" } }

    info = { id: { literal: url },
             updated: date,
             title: { literal: "The Atlantic" },
             author: { literal: "The Atlantic Monthly Group" } }

    entries = "div[class*=Item_info]"

    entry = { id: link,
              updated: date.merge!({ repeat: true }),
              title: "h3",
              author: "a[class*=_authorLink]",
              link: link,
              summary: "p" }

    rules = { info: info, entries: entries, entry: entry }

    Feedstock.feed url, rules
  end
end
