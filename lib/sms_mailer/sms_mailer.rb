module SmsMailer

	class << self
		attr_reader :configuration, :providers
		
		def config
			@configuration
		end
		
		def configure &block
			block.call(@configuration ||= Configuration.new) if block_given?
			
			@providers = Array.new
			if @configuration.respond_to? :provider
				begin
					provider = "#{@configuration.provider.to_s.titlecase}Provider".constantize.new
				rescue NameError
					provider = Provider.new(@configuration.provider)
				ensure
					@providers << provider
				end
			end
		end
		
		def get_provider hname
			@providers.select {|x| x.name.match(hname.to_s) }.first
		end
	end
end