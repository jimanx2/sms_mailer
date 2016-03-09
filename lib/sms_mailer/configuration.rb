module SmsMailer
	
	class Configuration 	
		def method_missing key, val = nil
			if key[-1].match(/\=/)
				self.class.send(:attr_accessor, key.to_s.gsub(/\=/,''))
				self.send(key.to_sym, val)
			else
				raise "Unsupported operation: calling undefined attribute"
			end
		end
	end
end