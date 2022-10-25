require 'valutec/api'

module Valutec
  class HighLevelApi
    @@card_program = "0xE8A72FDE1E31FF45ADE44460DB4B403B"

    def initialize(client_key:, terminal_id:, server_id:)
      @api = Api.new(client_key: client_key, terminal_id: terminal_id, server_id: server_id)
    end

    def card_balance(card_number)
      response = @api.card_balance({
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end

      response.dig("TransactionResponse", "Balance").to_f
    end

    def add_value(card_number, value)
      response = @api.add_value({
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
        "Amount" => value.to_f
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end

      response.dig("TransactionResponse", "Authorized")
    end

    def activate_card(card_number, value)
      response = @api.activate_card({
        "ProgramType" => "Gift",
        "CardNumber" => "%019d" % card_number,
        "Amount" => value.to_f
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end

      # Response.new(response, response["TransactionResponse"]["Balance"].to_f == value.to_f)
      response.dig("TransactionResponse", "Authorized")
    end

    # this may need :amount defined as well
    # def cash_out(card_number)
    #   response = @api.cash_out({
    #     "ProgramType" => "Gift",
    #     "CardNumber" => card_number,
    #   })
    # end

    # @param amount [Numeric]
    def create_card(amount)
      response = @api.create_card({
        "ProgramType" => "Gift",
        "CardProgram" => @@card_program, 
        "Amount" => amount
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end

      unless response.dig("TransactionResponse", "Authorized")
        # TODO
        raise "Not authorized" 
      end

      response.dig("TransactionResponse", "CardNumber")
    end

    def deactivate_card(card_number)
      response = @api.deactivate_card({
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end
    end
  
    def sale(card_number, amount)
      response = @api.sale({
        "ProgramType" => "Gift",
        "CardNumber" => "%019d" % card_number,
        "Amount" => amount.to_f
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end
    end

    # def replace_card(card_number, new_number)
    #   new_number = new_number.to_f
    #   response = @api.replace_card({
    #     "ProgramType" => "Gift",
    #     "CardNumber" => card_number,
    #   })
    # end

    def void(card_number)
      response = @api.void({
        "ProgramType" => "Gift",
        "CardNumber" => card_number,
      })

      unless response.dig("TransactionResponse", "ErrorMsg").nil?
        raise response.dig("TransactionResponse", "ErrorMsg")
      end
    end

    # private

    # def normalize_card_number(card_number)
    #   card_number.to_s.gsub(/\W/,'').to_i
    # end
  end
end
