require_relative 'test_helper'
require_relative '../lib/item'
require 'bigdecimal'
require 'pry'

class ItemTest < Minitest::Test
  def test_it_exits
    item = Item.new(id: 1,
                    name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: 1200,
                    merchant_id: 2,
                    created_at: Time.now,
                    updated_at: Time.now)

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new(id: 1,
                    name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: 1200,
                    merchant_id: 2,
                    created_at: Time.now,
                    updated_at: Time.now)

    assert_equal 1, item.id
    assert_equal 'Pencil', item.name
    assert_equal 'You can use it to write things', item.description
    assert_equal 1200, item.unit_price
    assert_equal 2, item.merchant_id
    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at
  end

  def test_unit_price_to_dollars
    item = Item.new(id: 1,
                    name: 'Pencil',
                    description: 'You can use it to write things',
                    unit_price: 1200,
                    merchant_id: 2,
                    created_at: Time.now,
                    updated_at: Time.now)

    assert_equal 12, item.unit_price_to_dollars
  end
end