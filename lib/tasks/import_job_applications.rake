require 'csv'
require 'date'

namespace :data do
  desc "Import job applications from CSV file"
  task import_applications: :environment do
    csv_path = Rails.root.join('claude_artifacts', 'Job-Search.csv')

    unless File.exist?(csv_path)
      puts "Error: CSV file not found at #{csv_path}"
      exit 1
    end

    successful_imports = 0
    failed_imports = 0
    errors = []

    CSV.foreach(csv_path, headers: true, encoding: 'UTF-8') do |row|
      # Skip empty rows
      next if row['Company Name'].blank?

      begin
        # Map CSV statuses to our enum values
        status_mapping = {
          'Applied' => 'applied',
          'Screening' => 'screening',
          'Rejected' => 'rejected',
          'Closed' => 'closed',
          'Withdrawn' => 'closed'
        }

        current_status = status_mapping[row['Status']] || 'applied'

        # Parse date with multiple formats
        application_date = parse_date(row['Application Date'])
        follow_up_date = parse_date(row['Follow-Up Date'])

        # Sanitize contact email (skip if it's a URL instead of email)
        contact_email = row['Contact Email']&.strip
        contact_email = nil if contact_email&.start_with?('http://', 'https://')

        # Create the application
        application = JobApplication.create!(
          company_name: row['Company Name'].strip,
          job_title: row['Job Title']&.strip || 'Not specified',
          application_link: row['Application Link']&.strip,
          application_date: application_date || Date.today,
          current_status: current_status,
          contact_name: row['Contact Name']&.strip,
          contact_email: contact_email,
          follow_up_date: follow_up_date,
          notes: row['Notes']&.strip
        )

        successful_imports += 1
        print "."
      rescue => e
        failed_imports += 1
        errors << "Row #{CSV::Row.new(row.headers, row.fields)}: #{e.message}"
        print "F"
      end
    end

    puts "\n\n"
    puts "=" * 60
    puts "Import Summary"
    puts "=" * 60
    puts "Successfully imported: #{successful_imports} applications"
    puts "Failed imports: #{failed_imports} applications"

    if errors.any?
      puts "\nErrors:"
      errors.each { |error| puts "  - #{error}" }
    end

    puts "=" * 60
  end

  private

  def parse_date(date_string)
    return nil if date_string.blank?

    # Handle 2-digit year format first (e.g., 8/19/25 -> 2025)
    # Must check this BEFORE trying strptime with %Y format
    if date_string.match?(%r{^\d{1,2}/\d{1,2}/\d{2}$})
      parts = date_string.split('/')
      month, day, year = parts[0].to_i, parts[1].to_i, parts[2].to_i
      # Assume years 00-99 mean 2000-2099
      full_year = year < 100 ? 2000 + year : year
      begin
        return Date.new(full_year, month, day)
      rescue ArgumentError
        # Invalid date, fall through to other formats
      end
    end

    # Try other date formats
    formats = [
      '%m/%d/%Y',   # 8/19/2025
      '%Y-%m-%d',   # 2025-08-19
      '%m/%d'       # 9/17 (assumes current year)
    ]

    formats.each do |format|
      begin
        if format == '%m/%d'
          return Date.strptime("#{date_string}/#{Date.today.year}", '%m/%d/%Y')
        else
          return Date.strptime(date_string, format)
        end
      rescue ArgumentError
        next
      end
    end

    nil
  rescue
    nil
  end
end
