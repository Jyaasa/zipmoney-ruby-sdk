module ZipMoney
	module Request
		Struct.new("Order", :id, :tax, :shipping_value, :total, :detail)
		Struct.new("Detail", :quantity, :name, :price, :description, :sku, :id, :category, :image_url)
		Struct.new("Address",:first_name, :last_name, :line1, :line2, :country, :zip, :city, :state)
		Struct.new("Consumer",:first_name, :last_name,:city, :phone, :gender, :dob, :email, :title)
		Struct.new("Metadata",:order_reference, :attributes)
		Struct.new("Version",:client, :platform)
		Struct.new("ApiCredentials",:merchant_id, :merchant_key, :version)
	end
end



