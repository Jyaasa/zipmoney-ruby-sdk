module ZipMoney
  class ApiError < StandardError; end 
  class InvalidArgumentError < StandardError; end 
  class RequestError < StandardError; end
  class ResponseError < StandardError; end
  class WebHookError < StandardError; end
  class WebHookRequestError < StandardError; end
  class ExpressError < StandardError; end
  class ExpressRequestError < StandardError; end
  class ExpressResponseError < StandardError; end
end