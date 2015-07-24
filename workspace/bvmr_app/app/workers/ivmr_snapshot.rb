require 'net/http'
require 'uri'

class IvmrSnapshot
	@queue = :ivmrs_queue
	def self.perform
		todays_date = Date.today

		start_date = Date.new(todays_date.year,todays_date.month,1).strftime("%d/%m/%Y")
		month=todays_date.month
		year = todays_date.year

		last_day = Time.days_in_month(month, year)
		end_date = Date.new(todays_date.year,todays_date.month,last_day).strftime("%d/%m/%Y")
		
		url = "http://torus.furlenco.com/openbravo/ws/com.promantia.furlenco.automation.GetInvoiceDetailsWebService?StartDate=#{start_date}&EndDate=#{end_date}"

		# uri = URI.parse(url)
		# http = Net::HTTP.new(uri.host, uri.port)
		# request = Net::HTTP::Get.new(uri.request_uri)
		# request.basic_auth('Furlenco', 'test')
		# response = http.request(request)
		
		# data = JSON.parse(response.body)

		auth = {username: "Furlenco", password: "test"}
		response = HTTParty.get(url, {basic_auth: auth})
		data = JSON.parse(response.body)

		total_invoice_amount = 0
		data.each do |item|
			total_invoice_amount += item['invoiceAmt']	
		end

		puts "Total invoice Amount : #{total_invoice_amount}"
		
		apitime=Time.now
		
		Ivmr.create!(ivmr_value: total_invoice_amount, api_time: apitime)

		puts 'IVMR Record Created'

	end	
end
