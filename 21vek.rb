require 'pp'
require 'nokogiri'
require 'open-uri'
require 'csv'
url = 'https://www.21vek.by/mobile/'
html = open(url)
doc = Nokogiri::HTML(html)
showings = doc.xpath('//ul[@class="b-result"]/li').map do |showing|

  showing = {name: showing.xpath('.//span[@class="result__name"]/text()').text,
             price: showing.xpath('.//span[@data-price]/@data-price').text,
            code: showing.xpath('.//span[@class="g-code"]/text()').text,
             diagon: showing.xpath('.//tr[contains(.,"Диагональ экрана")]//td[contains  (@class,"result__attr_var")]/text()').text,
             diagonal: showing.xpath('.//tr[contains(.,"Диагональ экрана")]//td[contains (@class,"result__attr_val")]/text()').text,
              op: showing.xpath('.//tr[contains(.,"Оперативная память")]//td[contains (@class,"result__attr_var")]/text()').text,
             oper:showing.xpath('.//tr[contains(.,"Оперативная память")]//td[contains (@class,"result__attr_val")]/text()').text
  }
end


url = doc.xpath('(//div[@id="j-paginator"]//a[@rel="next"]/preceding-sibling::a[1]/text()').text
pages = doc.xpath('(//div[@id="j-paginator"]//a[@rel="next"]/preceding-sibling::a[1]/text()').text
pages = []

for
url in pages

  puts url

end

puts url
html = open(url)
result = []
showings = doc.xpath('//ul[@class="b-result"]/li').map do |showing|
  result<<showing.xpath('.//span[@class="result__name"]/text()').text + " - " + showing.xpath('.//span[@data-price]/@data-price').text + " - " +showing.xpath('.//span[@class="g-code"]/text()').text
end
html = open(url)
doc = Nokogiri::HTML(html)
puts "____________________________________________________________"
showings = doc.xpath('//dd[contains (@class, "result__desc")]//tr[contains(.,"Диагональ экрана")]').map do |showing|
  showings = doc.xpath('//dd[contains (@class, "result__desc")]//tr[contains(.,"Оперативная память")]').map do |showing|
  puts showing.xpath('.//td[contains (@class, "result__attr_var")]/text()').text + " - " + showing.xpath('.//td[contains (@class,"result__attr_val")]/text()').text + " - " + showing.xpath('.//td[contains (@class,"result__attr_var")]/text()').text + " - "+ showing.xpath('.//td[contains (@class,"result__attr_val")]/text()').text
puts result .inspect
  end
  end

#document.at('table').search('dd').each {|row|
 # cells = row.search('dd, td').map {|cell| cell.text.strip}

  #puts CSV.generate_line(cells)
#}