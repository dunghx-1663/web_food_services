class Order < ApplicationRecord
  validates :address, presence: true
  validates :total_money, presence: true
  validates :customer_id, presence: true
  has_many :order_details, dependent: :destroy
  accepts_nested_attributes_for :order_details, allow_destroy: true
  belongs_to :employee, class_name: "User", optional: true
  belongs_to :customer, class_name: "User", optional: true
  
  delegate :name, to: :customer, prefix: true, allow_nil: true
  delegate :name, to: :employee, prefix: true, allow_nil: true
  
  scope :new_order, ->{
    where "status LIKE ?", Settings.status.new_order
  }

  scope :inprogress, ->{
    where "status LIKE ?", Settings.status.in_progress
  }

  scope :done, ->{
    where "status LIKE ?", Settings.status.done
  }

  scope :deliveried_in_month, ->{
    where("status = #{Settings.status.done} AND Month(created_at) = Month(CURDATE()) AND YEAR(created_at) = YEAR(CURDATE())")
  }

  scope :order_by_time, ->{order updated_at: :desc}
  
  def new?
    self.status == Settings.status.new_order
  end

  def in_progress?
    self.status == Settings.status.in_progress
  end

  def done?
    self.status == Settings.status.done
  end

  scope :ordered_by, -> customer_id {
    where("customer_id = ? AND status != ?", customer_id, Settings.status.done).order("created_at DESC")
  }
  
  scope :inprogress_status_by_employee, -> employee_id {
    where("employee_id = ? AND status = ?", employee_id, Settings.status.in_progress).order("created_at DESC")
  }

  scope :done_status_by_employee, -> employee_id {
    where("employee_id = ? AND status = ?", employee_id, Settings.status.done).order("created_at DESC")
  }

end
