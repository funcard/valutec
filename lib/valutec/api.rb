require 'httparty'

module Valutec
  class Api
    include HTTParty

    base_uri 'https://ws.valutec.net/Valutec.asmx'

    def initialize(client_key:, terminal_id:, server_id:)
      @client_key = client_key
      @terminal_id = terminal_id
      @server_id = server_id

      @options = {
        "ClientKey" => client_key,
        "TerminalID" => terminal_id,
        "ServerID" => server_id,
        "Identifier" => SecureRandom.uuid
      }
    end

    def card_balance(params)
      self.class.get('/Transaction_CardBalance', {query: params.merge(@options)})
    end

    def add_value(params)
      self.class.get('/Transaction_AddValue',{query: params.merge(@options)})
    end

    def activate_card(params)
      self.class.get('/Transaction_ActivateCard',{query: params.merge(@options)})
    end

    def cash_out(params)
      self.class.get('/Transaction_CashOut',{query: params.merge(@options)})
    end

    def create_card(params)
      self.class.get('/Transaction_CreateCard',{query: params.merge(@options)})
    end

    def deactivate_card(params)
      self.class.get('/Transaction_DeactivateCard',{query: params.merge(@options)})
    end

    def sale(params)
      self.class.get('/Transaction_Sale', {query: params.merge(@options)})
    end

    def host_totals(params)
      self.class.get('/Transaction_HostTotals', {query: params.merge(@options)})
    end

    def replace_card(params)
      self.class.get('/Transaction_ReplaceCard',{query: params.merge(@options)})
    end

    def restaurant_sale(params)
      raise "Valutec::Api#resturant_sale not implemented"
    end

    def void(params)
      self.class.get('/Transaction_Void',{query: params.merge(@options)})
    end
  end
end
