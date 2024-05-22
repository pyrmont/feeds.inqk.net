# frozen_string_literal: true

require "feedstock"

class NewYorker
  def feed
    url = "https://www.newyorker.com/magazine"

    date = Feedstock::Extract.new(
      selector: "p[class*=BundleHeaderDekText]",
      absolute: true,
      type: "datetime"
    )

    link = Feedstock::Extract.new(
      selector: "a.summary-item__hed-link",
      content: { attribute: "href" },
      prefix: "https://www.newyorker.com"
    )

    info = { id: url,
             updated: date,
             title: "The New Yorker",
             author: "Condé Nast" }

    entry = { id: link,
              updated: date,
              title: Feedstock::Extract.new(selector: "h3.summary-item__hed"),
              author: Feedstock::Extract.new(selector:"span.byline__name"),
              link: link,
              summary: Feedstock::Extract.new(selector: "div.summary-item__dek") }

    entries = Feedstock::Extract.new(selector: "div[id*=reporting] div.summary-item__content")

    rules = { info: info, entry: entry, entries: entries}

    Feedstock.feed url, rules
  end
end
