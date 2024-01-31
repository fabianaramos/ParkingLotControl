class Parking < ApplicationRecord
  validates :plate, presence: true
  validates :plate, format: { with: /\A[A-Z]{3}-\d{4}\z/ }
  validate :ensure_can_leave_park
  validate :ensure_can_create_park, on: :create

  def time
    paid? ? "#{((paid_at - created_at) / 60).to_i} minutes" : "#{((Time.now - created_at) / 60).to_i} minutes"
  end

  private

  def ensure_can_create_park
    unless Parking.where(plate: plate).where(paid: false).or(Parking.where(plate: plate).where(left: false)).present?
      return
    end

    errors.add(:plate, I18n.t('activerecord.errors.messages.didnt_leave_the_park'))
  end

  def ensure_can_leave_park
    return unless paid == false && left == true

    errors.add(:paid, I18n.t('activerecord.errors.messages.must_be_true_before_out'))
  end
end
