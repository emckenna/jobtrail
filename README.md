# JobTrail

A Rails-based job application tracker that helps job seekers understand their complete application lifecycle and identify where they're getting stuck in the hiring process.

## The Problem

Current job search tracking tools (spreadsheets, basic apps) don't capture the full application lifecycle, especially code assessments and rejection stages. Job seekers need better visibility into WHERE in the process they're getting rejected to improve their strategy.

## The Solution

JobTrail provides:

- **Full lifecycle tracking** - Track applications from submission through screening, assessment, interviewing, offer, or rejection
- **Rejection stage analytics** - Capture exactly which stage rejections happen at
- **Conversion insights** - Understand your conversion rates by stage
- **Pattern recognition** - Identify trends to improve your job search approach

## Core Features (MVP)

### Application Statuses
- **Applied** - Submitted application
- **Screening** - Recruiter/phone screen scheduled
- **Assessment** - Code challenge/take-home assigned
- **Interviewing** - Technical/on-site interviews
- **Offer** - Received offer
- **Rejected** - No at any stage (tracks WHICH stage)
- **Closed** - Withdrew or declined

### Analytics Dashboard
- Total applications
- Conversion rates by stage
- Average time in each stage
- Success rate trends
- Rejection pattern analysis

### Additional Features
- CRUD operations for job applications
- Status timeline tracking
- Search and filter by company, status, date range
- CSV import/export

## Tech Stack

- **Backend**: Ruby on Rails 7.x
- **Frontend**: Hotwire (Turbo + Stimulus)
- **Database**: PostgreSQL
- **Styling**: Tailwind CSS
- **Deployment**: Docker + Heroku (or similar)

## Prerequisites

- Ruby 3.x
- Rails 7.x
- PostgreSQL
- Docker & Docker Compose (for containerized development)

## Getting Started

### Using Docker (Recommended)

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/jobtrail.git
   cd jobtrail
   ```

2. Build and start the containers:
   ```bash
   docker-compose up --build
   ```

3. Create and setup the database:
   ```bash
   docker-compose run web rails db:create db:migrate
   ```

4. (Optional) Load seed data:
   ```bash
   docker-compose run web rails db:seed
   ```

5. Visit [http://localhost:3000](http://localhost:3000)

### Local Development (Without Docker)

1. Install dependencies:
   ```bash
   bundle install
   ```

2. Setup database:
   ```bash
   rails db:create db:migrate
   ```

3. Start the server:
   ```bash
   rails server
   ```

4. Visit [http://localhost:3000](http://localhost:3000)

## Data Model

### Job Application
- Company name (string, required)
- Job title (string, required)
- Application link (string)
- Application date (date, required)
- Current status (enum, required)
- Status updated date (datetime)
- Rejected at stage (enum, nullable)
- Salary range min/max (integer)
- Contact name (string)
- Contact email (string)
- Notes (text)
- Follow-up date (date)

## Importing Existing Data

If you have an existing CSV file of job applications:

```bash
# Place your CSV in the project root
docker-compose run web rails import:job_applications[path/to/your/file.csv]
```

## Running Tests

```bash
# With Docker
docker-compose run web rails test

# Without Docker
rails test
```

## Deployment

The application is containerized and ready for deployment to:
- Heroku (with PostgreSQL addon)
- AWS ECS/Fargate
- DigitalOcean App Platform
- Any Docker-compatible hosting

## Project Status

This is an active development project being used for real-world job tracking. The MVP focuses on core tracking and analytics features.

## Contributing

This is a personal project, but suggestions and feedback are welcome via issues.

## License

MIT

## Acknowledgments

Built out of necessity during a job search to solve a real problem - tracking where applications stall in the hiring funnel.
