class UsageHistory < ApplicationRecord
    def token_payment locale
      uri = URI "https://api-3t.sandbox.paypal.com/nvp"
      return_url = "http://localhost:3000/usage_histories/new"
      cancel_url = "http://localhost:3000/usage_histories/new"
      data = {USER: USERNAME, PWD: PASSWORD,
            SIGNATURE: SIGNATURE, VERSION: VERSION_API,
            PAYMENTREQUEST_0_PAYMENTACTION: "Sale",
            RETURNURL: return_url, CANCELURL: cancel_url,
            PAYMENTREQUEST_0_AMT: self.amount,
            PAYMENTREQUEST_0_CURRENCYCODE: "USD",
            METHOD: "SetExpressCheckout"}
      res = Net::HTTP.post_form uri, data
      response = to_hash res.body
      self.settlement_code = response[:TOKEN]
    end

      #Phân tích kết quả trả về dưới dạng hash
    def to_hash string
      string.split(/[&=]/).each_slice(2).inject({}) do |hash, i|
        hash[i.first.to_sym] = i.last
        hash
      end
    end

    def data_confirm token
        uri = URI "https://api-3t.sandbox.paypal.com/nvp"
        data = {USER: USERNAME, PWD: PASSWORD,
          SIGNATURE: SIGNATURE, VERSION: VERSION_API,
          TOKEN: token, METHOD: "GetExpressCheckoutDetails"}
        res = Net::HTTP.post_form uri, data
        response = to_hash res.body
        self.amount = response[:AMT]
        if datetime = Time.zone.parse(URI.decode(response[:TIMESTAMP]))
          self.used_date = datetime
        end
        self.settlement_code = token
    end

    def checkout_payment token, payer_id
        uri = URI "https://api-3t.sandbox.paypal.com/nvp"
        data = {USER: USERNAME, PWD: PASSWORD,
          SIGNATURE: SIGNATURE, VERSION: VERSION_API,
          PAYMENTREQUEST_0_PAYMENTACTION: "Sale",
          TOKEN: token,
          PAYERID: payer_id,
          PAYMENTREQUEST_0_AMT: self.amount,
          METHOD: "DoExpressCheckoutPayment",
          PAYMENTREQUEST_0_CURRENCYCODE: "USD"}
        res = Net::HTTP.post_form uri, data
        response = to_hash res.body
        if response[:ACK] == "Success"
          self.settlement_code = token
        end
    end
end
