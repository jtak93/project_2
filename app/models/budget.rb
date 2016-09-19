class Budget < ActiveRecord::Base
  belongs_to :user
  after_initialize :set_defaults, unless: :persisted?
  # The set_defaults will only work if the object is new

  def set_defaults
    self.budget_type  ||= 'monthly'
  end

end
