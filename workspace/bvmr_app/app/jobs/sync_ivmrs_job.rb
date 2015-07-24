require 'net/http'
require 'uri'

class SyncIvmrsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
  		
		todays_date = Date.today

		start_date = Date.new(todays_date.year,todays_date.month,1).strftime("%d/%m/%Y")
		month=todays_date.month
		year = todays_date.year

		last_day = Time.days_in_month(month, year)
		end_date = Date.new(todays_date.year,todays_date.month,last_day).strftime("%d/%m/%Y")
		puts ' Reached End date of IVMR'
		
		url = "http://torus.furlenco.com/openbravo/ws/com.promantia.furlenco.automation.GetInvoiceDetailsWebService?StartDate=#{start_date}&EndDate=#{end_date}"
		puts "Sent request"
		# uri = URI.parse(url)
		# http = Net::HTTP.new(uri.host, uri.port)
		# request = Net::HTTP::Get.new(uri.request_uri)
		# request.basic_auth('Furlenco', 'test')
		# response = http.request(request)
		
		# data = JSON.parse(response.body)

		auth = {username: "Furlenco", password: "test"}
		response = HTTParty.get(url, {basic_auth: auth})
		data = JSON.parse(response.body)
		puts("Got response in IVMR")

		begin
			total_invoice_amount = 0
			total_bvmr_amount = 0
			invoice_days=0
			data.each do |item|
				startday = item['startDate'].to_date.day
				# puts item['startDate']
				invoice_days = todays_date.day - startday
				inv_amt = item['invoiceAmt'] * invoice_days /30
				# total_invoice_amount += item['invoiceAmt']
				total_invoice_amount += inv_amt
				total_bvmr_amount += item['totalAmountDue']	
			end
		rescue => err
			puts err.inspect
		end

		puts "Total invoice Amount : #{total_invoice_amount}"
		puts "Total Bvmr Amount : #{total_bvmr_amount}"
		
		apitime=Time.now
		
		Ivmr.create!(ivmr_value: total_invoice_amount, api_time: apitime)
		Bvmr.create!(bvmr_value: total_bvmr_amount, api_time: apitime)

		puts 'IVMR Record Created'
		puts 'BVMR Record Created'
    # Do something later
  end
end
