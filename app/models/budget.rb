class Budget < ActiveRecord::Base
  belongs_to :user
  has_many :expenses, dependent: :destroy
  validates :budget, presence: true

  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  def set_defaults
    self.budget_type  ||= 'monthly'
    self[:expenses] = 0
  end

end
