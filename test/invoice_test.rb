require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'
require_relative '../lib/transaction'
require_relative '../lib/invoice_item'
require_relative '../lib/sales_engine'
require 'bigdecimal'
require 'pry'

class InvoiceTest < Minitest::Test
  def setup
    @invoice = Invoice.new({ id: 6,
                             customer_id: 7,
                             merchant_id: 8,
                             status: 'pending',
                             created_at: '2009-02-07',
                             updated_at: '2014-03-15' },
                           'parent')
  end

  def test_it_exists
    assert_instance_of Invoice, @invoice
  end

  def test_it_has_attributes
    assert_equal 6,        @invoice.id
    assert_equal 7,        @invoice.customer_id
    assert_equal 8,        @invoice.merchant_id
    assert_equal :pending, @invoice.status
  end

  def test_it_has_more_attributes
    assert_equal Time.parse('2009-02-07'), @invoice.created_at
    assert_equal Time.parse('2014-03-15'), @invoice.updated_at
    assert_equal 'parent',                 @invoice.parent
  end

  def test_it_can_return_merchant_class
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')

    invoice = se.invoices.find_by_id(1)
    assert_instance_of Merchant, invoice.merchant
    assert_equal 1,              invoice.merchant_id
  end

  def test_it_can_get_invoice_items
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    invoice = se.invoices.find_by_id(1)

    assert_instance_of InvoiceItem, invoice.invoice_items.first
    assert_equal 1,                 invoice.invoice_items.first.id
  end

  def test_it_can_get_transactions
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions_test.csv',
                              customers:     './test/fixtures/invoices.csv')

    assert_instance_of Transaction, invoice.transactions.first
    assert_equal 1,                 invoice.transactions.first.id
  end

  def test_it_can_get_transactions
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions_test.csv',
                              customers:     './test/fixtures/invoices.csv')
    invoice = se.invoices.find_by_id(1)

    assert_instance_of Customer, invoice.customer
    assert_equal 1,              invoice.transactions.first.id
  end

  def test_it_can_find_if_paid_in_full
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    invoice = se.invoices.find_by_id(1)
    assert invoice.is_paid_in_full?

    invoice = se.invoices.find_by_id(9)

    refute invoice.is_paid_in_full?
  end

  def test_it_can_find_a_total_amount
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    invoice = se.invoices.find_by_id(1)
    assert_equal 0.2106777e5, invoice.total
  end

  def test_it_can_find_total
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    assert_equal 21067.77, se.invoices.find_by_id(1).total
  end

  def test_it_can_find_quantity
    se = SalesEngine.from_csv(items:         './test/fixtures/items.csv',
                              merchants:     './test/fixtures/merchants.csv',
                              invoices:      './test/fixtures/invoices.csv',
                              invoice_items: './test/fixtures/invoice_items.csv',
                              transactions:  './test/fixtures/transactions.csv',
                              customers:     './test/fixtures/invoices.csv')
    assert_equal 47, se.invoices.find_by_id(1).quantity
  end
end
