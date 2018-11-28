require 'pp'
require 'nokogiri'
require 'open-uri'
require 'csv'
url = 'https://www.21vek.by/mobile/'
html = open(url)
doc = Nokogiri::HTML(html)
showings = []
doc.xpath('//ul[@class="b-result"]/li').each do |showing|

  showings << {name: showing.xpath('.//span[@class="result__name"]/text()').text,
             price: showing.xpath('.//span[@data-price]/@data-price').text,
               oldprice: showing.xpath('.//span[@data-old_price]/@data-old_price').text,
               logo: showing.xpath('.//img[@class="result__brand"]/@src').text[/brends\/(.*)\.png/,1],
               code: showing.xpath('.//span[@class="g-code"]/text()').text.gsub(/[^0-9\. ]/, ''),
             diagonal: showing.xpath('.//tr[contains(.,"Диагональ экрана")]//td[contains (@class,"result__attr_val")]/text()').text,
             oper:showing.xpath('.//tr[contains(.,"Оперативная память")]//td[contains (@class,"result__attr_val")]/text()').text
  }
end



pages = doc.xpath('//div[@id="j-paginator"]//a[@rel="next"]/preceding-sibling::a[1]/text()').text.to_i


for url in 2..pages

  url = "https://www.21vek.by/mobile/page:#{url}/"
  html = open(url)
  doc = Nokogiri::HTML(html)
  doc.xpath('//ul[@class="b-result"]/li').each do |showing|

    showings << {name: showing.xpath('.//span[@class="result__name"]/text()').text,
                price: showing.xpath('.//span[@data-price]/@data-price').text,
                 oldprice: showing.xpath('.//span[@data-old_price]/@data-old_price').text,
                 code: showing.xpath('.//span[@class="g-code"]/text()').text.gsub(/[^0-9\. ]/, ''),
                 logo: showing.xpath('.//img[@class="result__brand"]/@src').text[/brends\/(.*)\.png/,1],
                diagonal: showing.xpath('.//tr[contains(.,"Диагональ экрана")]//td[contains (@class,"result__attr_val")]/text()').text,
                oper:showing.xpath('.//tr[contains(.,"Оперативная память")]//td[contains (@class,"result__attr_val")]/text()').text
    }

  end
end

showings.each{|s| puts s }
puts url
html = open(url)
result = []
showings = doc.xpath('//ul[@class="b-result"]/li').map do |showing|
  result<<showing.xpath('.//span[@class="result__name"]/text()').text + " - " + showing.xpath('.//span[@data-price]/@data-price').text + " - "+showing.xpath('.//span[@data-old_price]/@data-old_price').text + " - " + showing.xpath('.//span[@class="g-code"]/text()').text.gsub(/[^0-9\. ]/, '')   #gsub("[^0-9\. ]")
end
html = open(url)
doc = Nokogiri::HTML(html)
puts "____________________________________________________________"
showings = doc.xpath('//dd[contains (@class, "result__desc")]//tr[contains(.,"Диагональ экрана")]').map do |showing|
  showings = doc.xpath('//dd[contains (@class, "result__desc")]//tr[contains(.,"Оперативная память")]').map do |showing|
  result<<showing.xpath('.//td[contains (@class, "result__attr_var")]/text()').text + " - " + showing.xpath('.//td[contains (@class,"result__attr_val")]/text()').text + " - " + showing.xpath('.//td[contains (@class,"result__attr_var")]/text()').text + " - "+ showing.xpath('.//td[contains (@class,"result__attr_val")]/text()').text + " - " + showing.xpath('.//img[@class="result__brand"]/@src').text[/brends\/(.*)\.png/,1]


  end
end
