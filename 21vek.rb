require 'pp'
require 'nokogiri'
require 'open-uri'
require 'csv'
require 'choice'

class Parser
  def initialize(url)

  end
end

SEED = 'https://www.21vek.by/mobile/'

def get_doc(url)
  puts url ||= SEED
  html = open(url)
  Nokogiri::HTML(html)
end

def get_hash(node)
  {
      name: node.xpath('.//span[@class="result__name"]/text()').text,
      price: node.xpath('.//span[@data-price]/@data-price').text,
      oldprice: node.xpath('.//span[@data-old_price]/@data-old_price').text,
      logo: node.xpath('.//img[@class="result__brand"]/@src').text[/brends\/(.*)\.png/, 1],
      code: node.xpath('.//span[@class="g-code"]/text()').text.gsub(/[^0-9\.]/, ''),
      diagonal: node.xpath('.//tr[contains(.,"Диагональ экрана")]//td[contains (@class,"result__attr_val")]/text()').text,
      oper: node.xpath('.//tr[contains(.,"Оперативная память")]//td[contains (@class,"result__attr_val")]/text()').text
  }
end

def get_page_result(doc)
  doc.xpath('//ul[@class="b-result"]/li').map do |showing|
    showings = get_hash(showing)
  end
end

showings = []
doc = get_doc(nil)
showings += get_page_result(doc)

pages = doc.xpath('//div[@id="j-paginator"]//a[@rel="next"]/preceding-sibling::a[1]/text()').text.to_i

(2..pages).each do |url|
  doc = get_doc("#{SEED}page:#{url}/")
  showings += get_page_result(doc)
end

showings.each {|s| puts s}
puts "size: #{showings.size}"

class CSV
  CSV.open("21vek.csv", "a+") do |csv|
  
  end
end



Choise.option do
header ''
  header 'change URL:'

    option :host do
      short '-h'
      long '--host = URL'
      desc 'you can change URL'
      default 'https://www.21vek.by/mobile/'
    end
end
puts 'host: ' + Choice[:host]

