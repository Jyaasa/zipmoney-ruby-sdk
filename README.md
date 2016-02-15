# Ruby SDK for zipMoney


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'zipMoney'
```

And then execute:

    $ bundle

Or install it yourself as:
    
    $ gem install zipMoney
    
## Usage
### Configuration
```ruby
require 'zipMoney' 
# Configure the api credentials 
ZipMoney::Configuration.merchant_id  = merchant_id
ZipMoney::Configuration.merchant_key = "merchant_key here"
ZipMoney::Configuration.environment  = 'sandbox|live'
```

### Api Operations  
##### Checkout
Order should be created before payment 

```ruby
# Initialize the checkout
checkout = ZipMoney::Checkout.new
        
checkout.params.charge        = false 					 
checkout.params.currency_code = "AUD"   
checkout.params.txn_id        = "12345" 
quote.params.cart_url         = "https://your-domain/checkout/cart/"
quote.params.success_url      = "https://your-domain/zipmoney/express/success/"
quote.params.cancel_url       = "https://your-domain/zipmoney/express/cancel/"
quote.params.error_url        = "https://your-domain/zipmoney/express/error/"
quote.params.refer_url        = "https://your-domain/zipmoney/express/refer/"
quote.params.decline_url      = "https://your-domain/zipmoney/express/decline/"
checkout.params.order_id      = "91005500"

# Order Info
checkout.params.order.id              = "91005500"
checkout.params.order.tax             = 0
checkout.params.order.shipping_value  = 0
checkout.params.order.total           = 339.95

# Initialize the new Order Detail Object
checkout.params.order.detail[0] = Struct::Detail.new
checkout.params.order.detail[0].quantity = 1
checkout.params.order.detail[0].name  = "GoPro Hero3+ Silver Edition - Silver"
checkout.params.order.detail[0].price = 339.95
checkout.params.order.detail[0].id  = 10758

# Billing Address - Optional
checkout.params.billing_address.first_name = "firstname"
checkout.params.billing_address.last_name  = "lastname"
checkout.params.billing_address.line1      = "address line 1"
checkout.params.billing_address.line2      = "address line 1"
checkout.params.billing_address.country    = "Australia"
checkout.params.billing_address.zip        = "postcode"
checkout.params.billing_address.city       = "Sydney"
checkout.params.billing_address.state      = "NSW"

# Shipping Address - Optional
checkout.params.shipping_address.first_name = "firstname"
checkout.params.shipping_address.last_name  = "lastname"
checkout.params.shipping_address.line1      = "address line 1"
checkout.params.shipping_address.line2      = "address line 1"
checkout.params.shipping_address.country    = "Australia"
checkout.params.shipping_address.zip        = "postcode"
checkout.params.shipping_address.city       = "Sydney"
checkout.params.shipping_address.state      = "NSW"

# Consumer Details - Optional
checkout.params.consumer.first_name = "first_name"
checkout.params.consumer.last_name  = "last_name"
checkout.params.consumer.phone      = "1234567890"
checkout.params.consumer.gender     = 1
checkout.params.consumer.email      = "your-email@email.com"
checkout.params.consumer.dob        = "0001-01-01T00:00:00"
checkout.params.consumer.title      = "title"

# Perform the Checkout call
response = checkout.do() 

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```
##### Quote
Order should be created after payment is complete, usually when the zipMoney api invokes the /confirmorder endpoint of the store or on the return journey

```ruby
# Initialize the checkout
quote = ZipMoney::Quote.new
        
quote.params.currency_code = "AUD"
quote.params.txn_id        = "12345"
quote.params.cart_url      = "https://your-domain/checkout/cart/"
quote.params.success_url   = "https://your-domain/zipmoney/express/success/"
quote.params.cancel_url    = "https://your-domain/zipmoney/express/cancel/"
quote.params.error_url     = "https://your-domain/zipmoney/express/error/"
quote.params.refer_url     = "https://your-domain/zipmoney/express/refer/"
quote.params.decline_url   = "https://your-domain/zipmoney/express/decline/"
quote.params.quote_id      = "91005500"
quote.params.checkout_source = "cart"

# Order Info
quote.params.order.id              = "91005500"
quote.params.order.tax             = 0
quote.params.order.shipping_value  = 0
quote.params.order.total           = 339.95

# Initialize the new Order Detail Object
quote.params.order.detail[0] = Struct::Detail.new
quote.params.order.detail[0].quantity = 1
quote.params.order.detail[0].name  = "GoPro Hero3+ Silver Edition - Silver"
quote.params.order.detail[0].price = 339.95
quote.params.order.detail[0].id  = 10758

# Billing Address - Optional
quote.params.billing_address.first_name = "firstname"
quote.params.billing_address.last_name  = "lastname"
quote.params.billing_address.line1      = "address line 1"
quote.params.billing_address.line2      = "address line 1"
quote.params.billing_address.country    = "Australia"
quote.params.billing_address.zip        = "postcode"
quote.params.billing_address.city       = "Sydney"
quote.params.billing_address.state      = "NSW"

# Shipping Address - Optional
quote.params.shipping_address.first_name = "firstname"
quote.params.shipping_address.last_name  = "lastname"
quote.params.shipping_address.line1      = "address line 1"
quote.params.shipping_address.line2      = "address line 1"
quote.params.shipping_address.country    = "Australia"
quote.params.shipping_address.zip        = "postcode"
quote.params.shipping_address.city       = "Sydney"
quote.params.shipping_address.state      = "NSW"

# Consumer Details - Optional
quote.params.consumer.first_name = "first_name"
quote.params.consumer.last_name  = "last_name"
quote.params.consumer.phone      = "1234567890"
quote.params.consumer.gender     = 1
quote.params.consumer.email      = "your-email@email.com"
quote.params.consumer.dob        = "0001-01-01T00:00:00"
quote.params.consumer.title      = "title"

# Perform the Quote call
response = quote.do()      

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```

##### Refund
Performs full or partial refund of the order

```ruby
# Initialize the refund
refund = ZipMoney::Refund.new

refund.params.reason        = "Refund Reason"
refund.params.txn_id        = 12345
refund.params.order_id      = 95001111

refund.params.order.id              = 95001111
refund.params.order.tax             = 0
refund.params.order.shipping_value  = 0
refund.params.order.total           = 339

refund.params.order.detail[0] = Struct::Detail.new
refund.params.order.detail[0].quantity = 1
refund.params.order.detail[0].name  = "Item Name"
refund.params.order.detail[0].price = 339
refund.params.order.detail[0].id  = 155

response = refund.do()  

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```


##### Cancel
Performs cancellation of the order

```ruby
# Initialize the cancel
cancel = ZipMoney::Cancel.new

cancel.params.txn_id        = 12345
cancel.params.order_id      = 95001111

cancel.params.order.id              = 95001111
cancel.params.order.tax             = 0
cancel.params.order.shipping_value  = 0
cancel.params.order.total           = 339

cancel.params.order.detail[0] = Struct::Detail.new
cancel.params.order.detail[0].quantity = 1
cancel.params.order.detail[0].name  = "Item Name"
cancel.params.order.detail[0].price = 339
cancel.params.order.detail[0].id  = 155

response = cancel.do()  

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```


##### Query
Queries orders
```ruby
# Initialize the query
query = ZipMoney::Query.new

query.params.orders[0] = Struct::QueryOrder.new
query.params.orders[0].id = 95000111
   
response = query.do()  

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```



##### Capture
Captures the payment for the order

```ruby
# Initialize the capture
capture = ZipMoney::Capture.new

capture.params.txn_id        = 12345
capture.params.order_id      = 95001111

capture.params.order.id              = 95001111
capture.params.order.tax             = 0
capture.params.order.shipping_value  = 0
capture.params.order.total           = 339

capture.params.order.detail[0] = Struct::Detail.new
capture.params.order.detail[0].quantity = 1
capture.params.order.detail[0].name  = "Item Name"
capture.params.order.detail[0].price = 339
capture.params.order.detail[0].id  = 155


response = capture.do()  

if response.isSuccess
   # do something
else
   # do something 
   # response.getError 
end   
```


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).