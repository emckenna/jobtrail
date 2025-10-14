# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [0.3.0] - 2025-10-13

### Added
- **Pagination**: Added Pagy gem for efficient pagination (25 items per page)
  - Custom Tailwind-styled pagination component with dark mode support
  - Page numbers, previous/next buttons, and result count display
- **CSV Import**: Rake task to import job applications from CSV files
  - Handles multiple date formats (MM/DD/YYYY, MM/DD/YY, MM/DD)
  - Gracefully handles invalid data (URLs in email fields, etc.)
  - Import summary with success/failure counts
- **Dark Mode Enhancements**:
  - Complete dark mode support for all form fields (new/edit pages)
  - Dark mode styling for job application show page
  - Improved status badge colors for better dark mode visibility
  - All text, backgrounds, and borders now support dark mode
- **UI Improvements**:
  - Icon-based action buttons (view/edit/delete) in job applications list
  - SVG icons for cleaner, more intuitive interface
  - Tooltips on icon buttons
- **Default Values**:
  - New applications automatically get follow-up date set to 7 days from today
  - Application date defaults to today's date

### Fixed
- **CSRF Token Error**: Fixed 422 errors on form submissions when accessing via localhost
  - Disabled origin check for CSRF protection in development
  - Added localhost to allowed hosts
- **Turbo JavaScript Conflict**: Fixed "Identifier already declared" error
  - Wrapped dark mode toggle script in IIFE for proper scoping
  - Added Turbo event listeners for proper page navigation handling
  - Prevents duplicate event listeners

### Changed
- Updated action links to icon buttons for more compact display
- Improved form field consistency across light and dark modes
- Enhanced pagination UI with better visual feedback

## [0.2.0] - 2025-10-13

### Added
- Job application CRUD functionality
  - Create, read, update, delete operations for job applications
  - Full form with all fields (company, title, status, dates, contacts, notes)
  - Show page with detailed application view
- Application index page with table layout
- Status badges with color coding
- Form validation and error handling
- Navigation bar with dark mode toggle
- Shared page wrapper component with flash messages
- Footer with branding

### Changed
- Updated color scheme from indigo/blue to teal/cyan theme
- Improved navigation button sizes and styling

## [0.1.0] - 2025-10-11

### Added
- Initial Rails 8 application setup with Docker
- PostgreSQL database configuration
- Tailwind CSS integration
- Landing page with hero section
- Docker Compose setup for local development
- Foreman configuration for running multiple processes (Rails + Tailwind CSS watch)
- JobApplication model with comprehensive fields:
  - Basic info: company_name, job_title, application_link
  - Dates: application_date, follow_up_date, status_updated_at
  - Status tracking: current_status (enum), rejected_at_stage (enum)
  - Salary: salary_range_min, salary_range_max
  - Contacts: contact_name, contact_email
  - Notes field
- Database migrations and schema
- Model validations and scopes
- Helper methods for data display

### Technical Details
- Ruby 3.3.6
- Rails 8.0.3
- PostgreSQL 16
- Tailwind CSS v4
- Docker-based development environment
- Propshaft asset pipeline

[Unreleased]: https://github.com/yourusername/jobtrail/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/yourusername/jobtrail/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/yourusername/jobtrail/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/yourusername/jobtrail/releases/tag/v0.1.0
