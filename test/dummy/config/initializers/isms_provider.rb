require 'net/http'
require 'cgi'

class IsmsProvider < SmsMailer::Provider
	ISMSHOST = "https://isms.com.my"
	ISMSSEND = "/isms_send.php"
	ISMSBAL  = "/isms_balance.php"
	
	def initialize
		super
	end
	
	def deliver! mail
		sms_content = mail.body
		params = { 
			'un' => ERB::Util::url_encode(@configuration.username),
			'pwd' => ERB::Util::url_encode(@configuration.password),
			'dstno' => mail.to.join(';'),
			'msg' => ERB::Util::url_encode(sms_content),
			'type' => 1,
			'sendid' => 'ABH'
		}

		data = "#{params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')}"
		@qstring = "#{ISMSSEND}?#{data}"

		url = URI.parse(ISMSHOST)

		Rails.logger.info "Sending SMS to #{mail.to}"
		res = Net::HTTP.get(url.host, @qstring)
		case res
			when "2000 = SUCCESS";
				Rails.logger.info "Success"
			when "";
				Rails.logger.warn "Unknown delivery status"
			else;
				raise "Sending Failed: #{res}"
		end
	rescue Exception => ex 
		Rails.logger.error ex.message
	end
	
	def get_balance
		params = { 
			'un' => ERB::Util::url_encode(@configuration.username),
			'pwd' => ERB::Util::url_encode(@configuration.password)
		}
		data = "#{params.collect { |k,v| "#{k}=#{CGI::escape(v.to_s)}" }.join('&')}"
		@qstring = "#{ISMSBAL}?#{data}"
		
		puts @qstring
		url = URI.parse(ISMSHOST)
		res = Net::HTTP.get(url.host, @qstring)
		
		res
	end
end