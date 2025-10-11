Job Hunt Tracker - Project Brief
The Problem
Current job search tracking (spreadsheets) doesn't capture the full application lifecycle, especially code assessments and rejection stages. Need better visibility into WHERE in the process candidates get stuck.
The Solution

Original CSV trackker file
./Job-Search.csv

A Rails-based job application tracker that:

Tracks full application lifecycle with proper status flow
Captures which stage rejections happen at
Provides analytics on conversion rates by stage
Helps job seekers identify patterns and improve

Core Features (MVP)
Application Statuses:

Applied - Submitted application
Screening - Recruiter/phone screen scheduled
Assessment - Code challenge/take-home assigned
Interviewing - Technical/on-site interviews
Offer - Received offer
Rejected - No at any stage (track WHICH stage)
Closed - Withdrew or declined

Data Model (Job Application):

Company name (string, required)
Job title (string, required)
Application link (string)
Application date (date, required)
Current status (enum, required)
Status updated date (datetime)
Rejected at stage (enum, nullable)
Salary range min/max (integer)
Contact name (string)
Contact email (string)
Notes (text)
Follow-up date (date)

Key Features:

CRUD for job applications
Status timeline tracking (when status changed)
Analytics dashboard showing:

Total applications
Conversion rates by stage
Average time in each stage
Success rate trends
Where rejections happen most


Simple search/filter by company, status, date
Export to CSV

Tech Stack (Option A - Simple Launch)

Backend: Ruby on Rails 7.x
Frontend: Hotwire (Turbo + Stimulus) - stay in Rails
Database: PostgreSQL
Styling: Tailwind CSS (simple, fast)
Deployment: Heroku (free tier or $5/mo)
Version Control: GitHub (public repo for portfolio)

Tech Stack (Option B - Portfolio Showcase)

Backend: Rails 7.x API mode
Frontend: React + TypeScript (learn React properly!)
Database: PostgreSQL
Styling: Tailwind CSS
Deployment: Backend on Heroku, Frontend on Vercel
Version Control: GitHub (public repo)

Development Timeline
Weekend 1 (MVP):

Setup Rails app
Build Job model + migrations
CRUD interface (index, show, new, edit)
Basic status tracking
Deploy to Heroku

Weekend 2 (Analytics):

Analytics dashboard
Charts/graphs (Chart.js or similar)
Filters and search
Polish UI

Ongoing:

Add features as needed while job hunting
Use it daily (dogfooding)
Iterate based on own usage

Strategic Value for Job Search
Interview Talking Points:

"I identified a gap in existing tools while job searching"
"Built this to solve my own problem - classic product thinking"
"Shows Rails expertise + ability to ship real software"
"Demonstrates understanding of user needs (I'm the user!)"

Resume/Portfolio:

Live deployed app to show
Public GitHub repo with good README
Proves you're actively coding
Differentiates from other candidates

Cover Letter Hook:
"While managing my job search, I identified limitations in existing tracking tools and built my own Rails application to solve it. This product-minded approach is how I think about engineering problems."
Success Criteria

 Functional CRUD for job applications
 All 7 statuses working correctly
 Basic analytics showing conversion rates
 Deployed and accessible via URL
 GitHub repo with clean README
 Added to resume under Projects
 Can demo in interviews

Next Steps

Decide on tech stack (Option A for speed, Option B for learning React)
Set up Rails project
Build core models
Deploy early and often
Use it immediately for real job tracking
