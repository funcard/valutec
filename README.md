# Valutec

This gem provides an interface to the Valutec Gift Card API, as [documented](https://ws.valutec.net/Valutec.asmx?WSDL).

## Installation

```ruby
gem "valutec", git: "https://github.com/funcard/Valutec"
```

An XML implementation is required in your project to parse the Valutec API responses.

## Usage

Low-level Client:

```ruby
require 'valutec'

client = Valutec::Api.new(
    client_key: "", 
    terminal_id: "", 
    server_id: "",
)

response = client.card_balance({
    "ProgramType" => "Gift",
    "CardNumber" => "11111222222",
})
puts response.to_h
```

High-Level Client:

```ruby
require 'valutec'

client = Valutec::HighLevelApi.new(
    client_key: "", 
    terminal_id: "", 
    server_id: "",
)

begin
    balance = client.card_balance("11111222222")
    puts balance
rescue => e
    puts e
end
```
