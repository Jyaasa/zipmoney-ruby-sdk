module ZipMoney
	class Settings
		include Request

		attr_accessor :params

		Struct.new("SettingsParams", :merchant_id, :merchant_key, :version, :metadata)
		
		def do	
			ZipMoney.api.settings()
		end
	end
end
