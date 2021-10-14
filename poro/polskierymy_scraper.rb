require 'json'

class PolskierymyScraper
  TEMPLATE = Addressable::Template.new('https://polskierymy.pl/{?query*}')

  def initialize(db)
    @db = db
  end

  def call(word)
    unescaped_word = CGI.unescape(word)
    fetch(word: unescaped_word)
  end

  private

  def fetch(word:)
    fetch_from_db(word: word)
  rescue IndexError
    results = fetch_from_web(word: word)
    json = results.to_json
    @db[word] = json
    results
  end

  def fetch_from_db(word:)
    json_string = @db.fetch(word)
    JSON.parse(json_string)
  end

  def fetch_from_web(word:)
    query_url = TEMPLATE.expand({
                                  "query": {
                                    "rymy": word
                                  }
                                })

    response = Typhoeus.get(query_url)
    doc = Nokogiri::HTML(response.body)
    doc.css('div.rhyme > p[data-n_syllables]')
       .group_by { |node| node.attributes['data-n_syllables'].value }
       .transform_values(&:first)
       .transform_values(&:children)
       .transform_values(&:text)
       .transform_values { |v| v.split(', ') }
  end
end
