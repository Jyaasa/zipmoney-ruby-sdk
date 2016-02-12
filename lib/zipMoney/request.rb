module ZipMoney
  module Request
    Struct.new("Order", :id, :tax, :shipping_value, :total, :detail)
    Struct.new("Detail", :quantity, :name, :price, :description, :sku, :id, :category, :image_url)
    Struct.new("Address",:first_name, :last_name, :line1, :line2, :country, :zip, :city, :state)
    Struct.new("Consumer",:first_name, :last_name,:city, :phone, :gender, :dob, :email, :title)
    Struct.new("Metadata",:order_reference, :attributes)
    Struct.new("Version",:client, :platform)
    Struct.new("ApiCredentials",:merchant_id, :merchant_key, :version)

    attr_accessor :errors

    def validate_item_details(order_items)
      order_items.each_with_index do |item,index|
        @errors << "order.detail[#{index}].id must be provided" if item.id.nil? 
        @errors << "order.detail[#{index}].name must be provided" if item.name.nil? 
        @errors << "order.detail[#{index}].quantity must be provided" if item.quantity.nil? 
        @errors << "order.detail[#{index}].price must be provided" if item.price.nil? 
      end 
    end 
  end
end