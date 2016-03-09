module SmsMailer

	class Provider
		attr_accessor :configuration, :name, :settings
		
		def initialize provider_klass = nil
			provider_klass ||= self.class.name.sub(/Provider/,'').downcase
			
			@name = provider_klass.to_s
			@settings = Hash.new
			@configuration ||= Configuration.new
			
			configfile = Rails.root.join('config', 'providers', "#{provider_klass}.yml")
			raise "Couldn't read provider file #{configfile}" unless File.exists? configfile
			
			configs = YAML.load_file(configfile)
			configs = configs[Rails.env] if configs.key? Rails.env
			
			configure do |cfg|
				configs.each do |k,v|
					cfg.send "#{k}=".to_sym, v
				end
			end
		end
		
		def configure &block
			block.call(@configuration) if block_given?
		end
		
		def deliver!; raise "Unimplemented method \`deliver_now!\` for provider #{self.name}"; end
		def bulk_send; raise "Unimplemented method \`bulk_send\` for provider #{self.name}"; end
		def get_balance; raise "Unimplemented method \`get_balance\` for provider #{self.name}"; end
	end
end