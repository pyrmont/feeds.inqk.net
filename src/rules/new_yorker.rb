# frozen_string_literal: true

require "feedstock"

class NewYorker
  def feed
    url = "https://www.newyorker.com/magazine"

    date = Feedstock::Extract.new(
      selector: "div[class*=MagazineHeader__header] h2",
      absolute: true,
      type: "datetime"
    )

    link = Feedstock::Extract.new(
      selector: "div[class*=River__riverItemBody] > a",
      content: { attribute: "href" },
      prefix: "https://www.newyorker.com"
    )

    info = { id: url,
             updated: date,
             title: "The New Yorker",
             author: "Condé Nast" }

    entry = { id: link,
              updated: date,
              title: Feedstock::Extract.new(selector: "h4[class*=River__hed]"),
              author: Feedstock::Extract.new(selector:"a[rel=author]"),
              link: link,
              summary: Feedstock::Extract.new(selector: "h5[class*=River__dek]") }

    entries = Feedstock::Extract.new(selector: "section > div[class*=Layout__layoutContainer] div[class*=River__riverItemContent]")

    rules = { info: info, entry: entry, entries: entries}

    Feedstock.feed url, rules
  end
end
