# frozen_string_literal: true

require "feedstock"

class TheAtlantic
  def feed
    url = "https://theatlantic.com/magazine"

    date = { "path" => "h1.c-section-header__title", 
             "type" => "datetime",
             "prepend" => "1 " } 

    link = { "path" => selector("> a"),
             "attribute" => "href",
             "prepend" => "https://theatlantic.com" }

    info = { "id" => { "literal" => url },
             "updated" => date,
             "title" => { "literal" => "The Atlantic" },
             "author" => { "literal" => "The Atlantic Monthly Group" } }

    entry = { "id" => link,
              "updated" => date.merge!({ "repeat" => true }),
              "title" => selector("h2.hed"),
              "author" => selector("li.byline"),
              "link" => link,
              "summary" => selector("p.dek") }

    rules = { "info" => info, "entry" => entry }

    Feedstock.feed url, rules
  end
  
  private def selector(partial)
    "ul[id*=section-Cover] > li.article #{partial},
     ul#section-Features > li.article #{partial}"
  end
end
