# frozen_string_literal: true

require "feedstock"

class Longform_TB
  def feed
    url = "https://longform.org/archive/writers/taffy-brodesser-akner"

    date = { path: "span.post__date",
             type: "datetime",
             prepend: "1 " }

    link = { path: "a.post__link",
             content: { attribute: "href" } }

    info = { id: { literal: url },
             updated: date,
             title: { literal: "Longform: Taffy Brodesser-Akner" },
             author: { literal: "Taffy Brodesser-Akner" } }

    entries = "article.post"

    entry = { id: link,
              updated: date,
              title: "h2.post__title",
              author: "span.post__author",
              link: link,
              summary: "div.post__text" }

    rules = { info: info, entries: entries, entry: entry }

    Feedstock.feed url, rules
  end
end
