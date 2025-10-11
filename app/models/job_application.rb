class JobApplication < ApplicationRecord
  # Validations
  validates :company_name, presence: true
  validates :job_title, presence: true
  validates :application_date, presence: true
  validates :current_status, presence: true
  validates :contact_email, format: { with: URI::MailTo::EMAIL_REGEXP, allow_blank: true }
  validate :salary_range_validation

  # Enums for status tracking
  enum :current_status, {
    applied: "applied",
    screening: "screening",
    assessment: "assessment",
    interviewing: "interviewing",
    offer: "offer",
    rejected: "rejected",
    closed: "closed"
  }, default: :applied, validate: true

  # Enum for tracking which stage rejection occurred at
  enum :rejected_at_stage, {
    rejected_at_applied: "applied",
    rejected_at_screening: "screening",
    rejected_at_assessment: "assessment",
    rejected_at_interviewing: "interviewing",
    rejected_at_offer: "offer"
  }, validate: { allow_nil: true }

  # Scopes
  scope :active, -> { where.not(current_status: ["rejected", "closed"]) }
  scope :recent, -> { order(application_date: :desc) }
  scope :with_follow_up, -> { where.not(follow_up_date: nil).where("follow_up_date >= ?", Date.today) }
  scope :overdue_follow_up, -> { where("follow_up_date < ?", Date.today) }
  scope :by_status, ->(status) { where(current_status: status) }
  scope :by_company, ->(company) { where("company_name ILIKE ?", "%#{company}%") }

  # Callbacks
  before_save :update_status_timestamp, if: :current_status_changed?

  # Instance methods
  def days_since_application
    return 0 unless application_date
    (Date.today - application_date).to_i
  end

  def has_follow_up?
    follow_up_date.present?
  end

  def follow_up_overdue?
    follow_up_date.present? && follow_up_date < Date.today
  end

  def salary_range_display
    return "Not specified" if salary_range_min.nil? && salary_range_max.nil?
    return "$#{salary_range_min.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}+" if salary_range_max.nil?
    return "Up to $#{salary_range_max.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}" if salary_range_min.nil?
    "$#{salary_range_min.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse} - $#{salary_range_max.to_s.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse}"
  end

  # Class methods
  def self.statistics
    {
      total: count,
      active: active.count,
      by_status: group(:current_status).count,
      rejected_stages: where(current_status: "rejected").group(:rejected_at_stage).count,
      avg_days_to_rejection: where(current_status: "rejected").average("DATE_PART('day', status_updated_at - application_date)").to_f.round(1)
    }
  end

  def self.conversion_rates
    total = count.to_f
    return {} if total.zero?

    {
      screening_rate: (where(current_status: ["screening", "assessment", "interviewing", "offer"]).count / total * 100).round(1),
      assessment_rate: (where(current_status: ["assessment", "interviewing", "offer"]).count / total * 100).round(1),
      interview_rate: (where(current_status: ["interviewing", "offer"]).count / total * 100).round(1),
      offer_rate: (where(current_status: "offer").count / total * 100).round(1)
    }
  end

  private

  def update_status_timestamp
    self.status_updated_at = Time.current
  end

  def salary_range_validation
    if salary_range_min.present? && salary_range_max.present? && salary_range_min > salary_range_max
      errors.add(:salary_range_min, "cannot be greater than maximum")
    end
  end
end
