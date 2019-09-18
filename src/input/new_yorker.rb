# frozen_string_literal: true

require "feedstock"

class NewYorker
  def feed
    url = "https://www.newyorker.com/magazine"

    date = { "path" => "div[class*=MagazineHeader__header] h2", 
             "type" => "datetime" }

    link = { "path" => selector("div[class*=River__riverItemBody] > a"),
             "attribute" => "href",
             "prepend" => "https://www.newyorker.com" }

    info = { "id" => { "literal" => url },
             "updated" => date,
             "title" => { "literal" => "The New Yorker" },
             "author" => { "literal" => "Condé Nast" } }

    entries = { "id" => link,
                "updated" => date.merge({ "repeat" => true }),
                "title" => selector("h4[class*=River__hed]"),
                "author" => selector("a[rel=author]"),
                "link" => link,
                "summary" => selector("h5[class*=River__dek]") }

    rules = { "info" => info, "entries" => entries }

    Feedstock.feed url, rules
  end
  
  private def selector(partial)
    "section > div[class*=Layout__layoutContainer] section[class*=MagazinePageSection] div[class*=River__riverItemContent] #{partial}"
  end
end
