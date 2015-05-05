class Item < ActiveRecord::Base
  # include CacheInvalidator

  belongs_to :user

  has_many :order_items
  has_many :orders, through: :order_items

  after_create  :update_orders
  after_update  :update_orders
  after_destroy :update_orders

  def update_orders
   orders.each do |order|
     order.updated_at = Time.now
     order.save
   end
  end
end
