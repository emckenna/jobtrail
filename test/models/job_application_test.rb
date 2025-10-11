require "test_helper"

class JobApplicationTest < ActiveSupport::TestCase
  def setup
    @job_application = JobApplication.new(
      company_name: "Test Company",
      job_title: "Software Engineer",
      application_date: Date.today
    )
  end

  test "should be valid with required attributes" do
    assert @job_application.valid?
  end

  test "should require company name" do
    @job_application.company_name = nil
    assert_not @job_application.valid?
    assert_includes @job_application.errors[:company_name], "can't be blank"
  end

  test "should require job title" do
    @job_application.job_title = nil
    assert_not @job_application.valid?
    assert_includes @job_application.errors[:job_title], "can't be blank"
  end

  test "should require application date" do
    @job_application.application_date = nil
    assert_not @job_application.valid?
    assert_includes @job_application.errors[:application_date], "can't be blank"
  end

  test "should have default status of applied" do
    @job_application.save
    assert_equal "applied", @job_application.current_status
  end

  test "should validate email format" do
    @job_application.contact_email = "invalid_email"
    assert_not @job_application.valid?

    @job_application.contact_email = "valid@example.com"
    assert @job_application.valid?
  end

  test "should validate salary range" do
    @job_application.salary_range_min = 100000
    @job_application.salary_range_max = 80000
    assert_not @job_application.valid?
    assert_includes @job_application.errors[:salary_range_min], "cannot be greater than maximum"
  end

  test "should update status timestamp on status change" do
    @job_application.save
    original_time = @job_application.status_updated_at

    @job_application.current_status = "screening"
    @job_application.save

    assert_not_equal original_time, @job_application.status_updated_at
  end

  test "should calculate days since application" do
    @job_application.application_date = 5.days.ago
    assert_equal 5, @job_application.days_since_application
  end

  test "should check if follow up is overdue" do
    @job_application.follow_up_date = 2.days.ago
    assert @job_application.follow_up_overdue?

    @job_application.follow_up_date = 2.days.from_now
    assert_not @job_application.follow_up_overdue?
  end

  test "should format salary range display" do
    @job_application.salary_range_min = 80000
    @job_application.salary_range_max = 120000
    assert_equal "$80,000 - $120,000", @job_application.salary_range_display
  end
end
