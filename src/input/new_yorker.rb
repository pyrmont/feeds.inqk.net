# frozen_string_literal: true

require "feedstock"

class NewYorker
  def feed
    url = "https://www.newyorker.com/magazine"

    date = { path: "div[class*=MagazineHeader__header] h2",
             type: "datetime" }

    link = { path: "div[class*=River__riverItemBody] > a",
             content: { attribute: "href" },
             prepend: "https://www.newyorker.com" }

    info = { id: { literal: url },
             updated: date,
             title: { literal: "The New Yorker" },
             author: { literal: "Condé Nast" } }

    entries = "section > div[class*=Layout__layoutContainer] div[class*=River__riverItemContent]"

    entry = { id: link,
              updated: date.merge({ repeat: true }),
              title: "h4[class*=River__hed]",
              author: "a[rel=author]",
              link: link,
              summary: "h5[class*=River__dek]" }

    rules = { info: info, entries: entries, entry: entry }

    Feedstock.feed url, rules
  end
end
