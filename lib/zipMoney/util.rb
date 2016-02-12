module ZipMoney
  class Util
    class << self
      
    # Converts Struct objects to Hash
    #
    # @param [object] Struct Object 
    #
    # @return Hash
    def struct_to_hash(object)
      hash = {}
      object.to_h.each  do |k,v| 
        if v.is_a?(Struct) 
          v = struct_to_hash(v)
          hash[k] = v unless v.empty?
        elsif v.is_a?(Array)
          
          a = Array.new
          v.each_with_index do  |k1,v1|  
            v2 = struct_to_hash(k1) 
            a[v1] = v2  unless v2.empty?
          end

          hash[k] = a
        else
          hash[k] = v unless v.nil?
        end
      end
        hash
    end 

    # Converts Hash|Struct|OpenStruct objects to Hash
    #
    # @param [data] Json String 
    #
    # @return data
    def json_parse(data)
      begin
        data =  JSON.parse(data)
      rescue TypeError => e         
        if !data.is_a?(Hash) && !data.is_a?(Struct) && !data.is_a?(OpenStruct)
      raise ArgumentError, "Invalid params provided" 
        end
      rescue JSON::ParserError => e
        if !data.is_a?(Hash) && !data.is_a?(Struct) && !data.is_a?(OpenStruct)
      raise ArgumentError, "Invalid params provided" 
        end
      end
      data
    end
    end
  end 
end