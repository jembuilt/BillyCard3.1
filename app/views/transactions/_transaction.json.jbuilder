json.extract! transaction, :id, :Date, :amount, :credit_card_id, :created_at, :updated_at
json.url transaction_url(transaction, format: :json)
