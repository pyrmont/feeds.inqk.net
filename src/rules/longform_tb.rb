# frozen_string_literal: true

require "feedstock"

class LongformTb
  def feed
    url = "https://longform.org/archive/writers/taffy-brodesser-akner"

    date = Feedstock::Extract.new(
      selector: "span.post__date",
      type: "datetime",
      prefix: "1 "
    )

    link = Feedstock::Extract.new(
      selector: "a.post__link",
      content: { attribute: "href" }
    )

    info = { id: url,
             updated: date,
             title: "Longform: Taffy Brodesser-Akner",
             author: "Taffy Brodesser-Akner" }

    entry = { id: link,
              updated: date,
              title: Feedstock::Extract.new(selector: "h2.post__title"),
              author: Feedstock::Extract.new(selector: "span.post__author"),
              link: link,
              summary: Feedstock::Extract.new(selector: "div.post__text") }

    entries = Feedstock::Extract.new(selector: "article.post")

    rules = { info: info, entry: entry, entries: entries }

    Feedstock.feed url, rules
  end
end
