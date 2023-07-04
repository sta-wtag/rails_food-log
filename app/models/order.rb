class Order < ApplicationRecord
    enum order_status: {
      pending:0,
      payment_received:1,
      order_confirmed:2,
      failed:3,
      expired:4,
      on_hold:5,
      canceled:6,
      disputed:7
    }
    after_initialize :set_default_order_status, if: :new_record?

    belongs_to :user
    has_many :ordered_items, dependent: :destroy
    has_many :items, through: :ordered_items
    private

    def set_default_order_status
        self.order_status ||= :pending
    end
end
