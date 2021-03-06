require_relative 'test_helper'
require_relative '../lib/customer'

# test for customer class
class CustomerTest < Minitest::Test
  def setup
    @customer = Customer.new(id: 6,
                             first_name: 'Joan',
                             last_name: 'Clarke',
                             created_at: Time.now,
                             updated_at: Time.now)
  end

  def test_class_can_be_instantiated
    assert_instance_of Customer, @customer
  end

  def test_class_has_attributes
    assert_equal 6,          @customer.id
    assert_equal 'Joan',     @customer.first_name
    assert_equal 'Clarke',   @customer.last_name
    assert_instance_of Time, @customer.created_at
    assert_instance_of Time, @customer.updated_at
  end

  def test_invoices_method
    parent = mock
    parent.stubs(:pass_customer_id_to_se).returns([])
    customer = Customer.new({ id: 6,
                              first_name: 'Joan',
                              last_name: 'Clarke',
                              created_at: Time.now,
                              updated_at: Time.now }, parent)

    assert_equal customer.invoices, parent.pass_customer_id_to_se
    assert_equal parent, customer.parent
  end

  def test_merchants_method
    parent = mock
    invoice = mock
    parent.stubs(:pass_customer_id_to_se).returns([invoice])
    invoice.stubs(:merchant_id).returns(1)
    parent.stubs(:pass_merchant_id_to_se).returns('merchant')
    customer = Customer.new({ id: 6,
                              first_name: 'Joan',
                              last_name: 'Clarke',
                              created_at: Time.now,
                              updated_at: Time.now }, parent)
    assert_equal ['merchant'], customer.merchants
  end

  def test_fully_paid_invoices
    parent = mock
    invoice = mock
    parent.stubs(:pass_customer_id_to_se).returns([invoice])
    invoice.stubs(:merchant_id).returns(1)
    invoice.stubs(:is_paid_in_full?).returns(true)
    parent.stubs(:pass_merchant_id_to_se).returns('merchant')
    customer = Customer.new({ id: 6,
                              first_name: 'Joan',
                              last_name: 'Clarke',
                              created_at: Time.now,
                              updated_at: Time.now }, parent)
    assert_equal [invoice], customer.fully_paid_invoices
  end
end
