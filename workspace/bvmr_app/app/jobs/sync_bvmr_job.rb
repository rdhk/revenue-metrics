require 'net/http'
require 'uri'

class SyncBvmrJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
  		# puts backtrace
		todays_date = Date.today
		puts ' Reached BVMR Start date'

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
		api_response = response.body
		# puts "Received API Response"
		# puts api_response
		data = JSON.parse(api_response)
		# puts "here2"
		# puts data.inspect
		# puts "here"

		total_bvmr_amount = 0

		data.each_with_index do |item, index|
			# puts "processing item #{index}"
			total_bvmr_amount += item['totalAmountDue']	
		end
		puts "Total Bvmr Amount : #{total_bvmr_amount}"
		
		apitime=Time.now
		
		Bvmr.create!(bvmr_value: total_bvmr_amount, api_time: apitime)

		puts 'BVMR Record Created'
    # Do something later
  end
end
