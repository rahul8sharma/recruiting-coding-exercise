require 'open-uri'

module Currency
	# Use the background job to overwrite a file once in a day
	# Now I am using method to handle this
	# Seting yesterday date
	@@expires_at = Time.now - 86400
	@@currencies = {}

	def self.get_currencies
		# If date changed then it will overwrite the file
		if(@@expires_at > Time.now && @@currencies.present?)
			return @@currencies
		else
			# Overwrite the file in night 12 PM
			@@expires_at = Time.now.end_of_day + 1

			# Collect the today currencies
			@@currencies = self.collect_correncies

			return @@currencies
		end
	end

	def self.create_currency_rate_file
		begin
			#Connect to data source and download XML data file locally
			# Get the exchange url from secret file
			data_source = (open(Rails.application.secrets.EXCHANGE_RATES_URL))

			# Now I am create this file in root directory.
			# We can also save it tmp directory
			IO.copy_stream(data_source, 'currency_rates.xml')
		rescue OpenURI::HTTPError => ex
			raise 'URL not found'
		end
	end

	def self.collect_correncies
		self.create_currency_rate_file

		#Read XML file and parse into Nokogiri object
		xml = File.read('currency_rates.xml')
		doc = Nokogiri::XML(xml)

		# Take today correncies from the object using Nokogiri
		today_currency = doc.xpath('//*[@time]').first.children
		# Collect all currencies of today
		HashWithIndifferentAccess[
			today_currency.collect do |currency|
				[currency['currency'], currency['rate']]
			end
		].merge({EUR: 1.0})
	end
end