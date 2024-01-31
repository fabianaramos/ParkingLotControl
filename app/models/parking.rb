class Parking < ApplicationRecord
  validates :plate, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}-\d{4}\z/ }
  validate :ensure_can_leave_park

  def time
    paid? ? "#{((paid_at - created_at) / 60).to_i} minutes" : "#{((Time.now - created_at) / 60).to_i} minutes"
  end

  private

  def ensure_can_leave_park
    return unless paid == false && left == true

    errors.add(:paid, t('activerecord.errors.messages.must_be_true_before_out'))
  end
end
