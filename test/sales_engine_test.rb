require_relative 'test_helper'
require_relative '../lib/sales_engine'
require 'pry'

# test for the sales engine
class SalesengineTest < Minitest::Test
  def setup
    @se = SalesEngine.from_csv(items: './test/fixtures/items.csv',
                               merchants: './test/fixtures/merchants.csv',
                               invoices: './test/fixtures/invoices.csv',
                               invoice_items: './test/fixtures/invoice_items.csv',
                               transactions: './test/fixtures/transactions.csv',
                               customers: './test/fixtures/customers.csv')
  end

  def test_it_exists
    assert_instance_of SalesEngine, @se
  end

  def test_it_has_item_repo
    name = 'Glitter scrabble frames'

    assert_instance_of ItemRepository, @se.items
    assert_instance_of Array,          @se.items.all
    assert_instance_of Item,           @se.items.find_by_name(name)
    assert_instance_of Item,           @se.items.find_by_id(1)
  end

  def test_item_repo_integration
    string = 'Any colour glitter'

    assert_instance_of Item, @se.items.find_all_with_description(string)[0]
    assert_equal [],         @se.items.find_all_by_price(1000.00)
    assert_equal [],         @se.items.find_all_by_merchant_id(12_345)
  end

  def test_it_has_merchant_repo
    assert_instance_of MerchantRepository, @se.merchants
    assert_instance_of Array,              @se.merchants.all
  end

  def test_merchant_repo_integration_tests
    name = 'Shopin1901'

    assert_instance_of Merchant, @se.merchants.find_by_name(name)
    assert_instance_of Merchant, @se.merchants.find_by_id(1)
    assert_instance_of Merchant, @se.merchants.find_all_by_name('Sho')[0]
  end

  def test_it_has_invoice_repo
    assert_instance_of InvoiceRepository, @se.invoices
    assert_instance_of Array,             @se.invoices.all
  end

  def test_it_has_invoice_item_repo
    assert_instance_of InvoiceItemRepository, @se.invoice_items
    assert_instance_of Array,                 @se.invoice_items.all
  end

  def test_it_has_transaction_repo
    assert_instance_of TransactionRepository, @se.transactions
    assert_instance_of Array,                 @se.transactions.all
  end

  def test_it_has_customer_repo
    assert_instance_of CustomerRepository, @se.customers
    assert_instance_of Array,              @se.customers.all
  end

  def test_pass_merchant_id_to_merchant_repo
    expected = @se.pass_merchant_id_to_merchant_repo(2)
    assert_equal expected, @se.merchants.find_by_id(2)
  end

  def test_pass_id_to_item_repo
    expected = @se.pass_id_to_item_repo(2)
    assert_equal expected, @se.items.find_all_by_merchant_id(2)
  end

  def test_pass_id_to_invoice_repo
    expected = @se.pass_id_to_invoice_repo(2)
    assert_equal expected, @se.invoices.find_all_by_merchant_id(2)
  end

  def test_pass_id_to_invoice_items_repo
    expected = @se.pass_id_to_invoice_items_repo(2)
    assert_equal expected, @se.invoice_items.find_all_by_invoice_id(2)
  end

  def test_pass_id_to_transaction_repo
    expected = @se.pass_id_to_transaction_repo(2)
    assert_equal expected, @se.transactions.find_all_by_invoice_id(2)
  end

  def test_pass_id_to_customer_repo
    expected = @se.pass_id_to_customer_repo(2)
    assert_equal expected, @se.customers.find_by_id(2)
  end

  def test_pass_id_for_invoice
    expected = @se.pass_id_for_invoice(2)
    assert_equal expected, @se.invoices.find_by_id(2)
  end

  def test_pass_customer_id_to_invoices
    expected = @se.pass_customer_id_to_invoices(2)
    assert_equal expected, @se.invoices.find_all_by_customer_id(2)
  end
end
