require 'rubygems'

namespace :sales do
	task :test_ivmr => :environment do

		todays_date = Date.today

		start_date = Date.new(todays_date.year,todays_date.month,1).strftime("%d/%m/%Y")
		month=todays_date.month
		year = todays_date.year

		last_day = Time.days_in_month(month, year)
		end_date = Date.new(todays_date.year,todays_date.month,last_day).strftime("%d/%m/%Y")
		puts ' Reached End date of IVMR'
		
		# url = "http://torus.furlenco.com/openbravo/ws/com.promantia.furlenco.automation.GetInvoiceDetailsWebService?StartDate=#{start_date}&EndDate=#{end_date}"
		# puts "Sent request"
		# uri = URI.parse(url)
		# http = Net::HTTP.new(uri.host, uri.port)
		# request = Net::HTTP::Get.new(uri.request_uri)
		# request.basic_auth('Furlenco', 'test')
		# response = http.request(request)
		
		# data = JSON.parse(response.body)

		# auth = {username: "Furlenco", password: "test"}
		# response = HTTParty.get(url, {basic_auth: auth})
		response = [{"invoiceNo":"KRY15BLRA1000002186","customerSearchKey":"VEN\/00001000269","invoiceAmt":2500,"totalAmountDue":0E-22,"invoiceDate":"2015-07-17 00:00:00","startDate":"2015-07-17 00:00:00","endDate":"2015-07-31 00:00:00","orderNo":"SO\/1001937"},{"invoiceNo":"KRY15BLRA1000002184","customerSearchKey":"VEN\/00001000262","invoiceAmt":2000,"totalAmountDue":0E-22,"invoiceDate":"2015-07-17 00:00:00","startDate":"2015-07-17 00:00:00","endDate":"2015-07-31 00:00:00","orderNo":"SO\/1001933"},{"invoiceNo":"KRY15BLRA1000002195","customerSearchKey":"VEN\/00001000251","invoiceAmt":10016,"totalAmountDue":9017,"invoiceDate":"2015-07-18 00:00:00","startDate":"2015-07-18 00:00:00","endDate":"2015-07-31 00:00:00","orderNo":"SO\/1001912"},{"invoiceNo":"KRY15BLRA1000002210","customerSearchKey":"CUS\/00001001869","invoiceAmt":1275,"totalAmountDue":-725,"invoiceDate":"2015-07-20 00:00:00","startDate":"2015-07-20 00:00:00","endDate":"2015-07-31 00:00:00","orderNo":"SO\/1001975"}]
		data = JSON.parse(response.body)
		puts("Got response in IVMR")

		begin
			total_invoice_amount = 0
			invoice_days=0
			data.each do |item|
				startday = item['startDate'].days_in_month
				puts item['startDate']
				invoice_days = todays_date.day - startday
				inv_amt = item['invoiceAmt'] * invoice_days /30
				# total_invoice_amount += item['invoiceAmt']
				total_invoice_amount += inv_amt
			end
		rescue => err
			puts e.inspect
		end

		puts "Total invoice Amount : #{total_invoice_amount}"
		
		apitime=Time.now
		
		Ivmr.create!(ivmr_value: total_invoice_amount, api_time: apitime)

		puts 'IVMR Record Created'
	end	
end

