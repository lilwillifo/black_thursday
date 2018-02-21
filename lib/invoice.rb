require 'time'
require 'bigdecimal'

# class for individual invoices
class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status = data[:status]
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end
end