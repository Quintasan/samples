require_relative './polskierymy_scraper'

DB = DBM.open('rhymes.dbm', 0666, DBM::WRCREAT) # rubocop:disable Style/NumericLiteralPrefix

class App < Roda
  plugin :json

  route do |r|
    r.root do
      {
        message: 'Use `GET rhymes/<word>` query to fetch rhyming words'
      }
    end

    r.get 'rhymes', String do |word|
      PolskierymyScraper.new(DB).call(word)
    end
  end
end
