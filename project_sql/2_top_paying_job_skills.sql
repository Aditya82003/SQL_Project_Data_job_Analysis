/*
 =========================================================
 QUESTION: What are the skills required for the top 10 highest-paying remote Data Analyst jobs?
 
 GOAL: Identify the top 10 highest-paying remote Data Analyst jobs and determine the skills required for each position.
 
 APPROACH:
 1. Identify remote Data Analyst job postings with specified average yearly salaries.
 2. Join job postings with company information to identify the companies offering these opportunities.
 3. Sort jobs by average yearly salary in descending order.
 4. Select the top 10 highest-paying jobs.
 5. Join the selected jobs with the skills tables to identify the skills required for each job.
 
 =========================================================
 */
 
WITH top_paying_jobs AS (
    select job_id,
        company_dim.name AS company_name,
        job_title,
        job_location,
        job_schedule_type,
        job_posted_date::Date,
        salary_year_avg
    from job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE salary_year_avg IS NOT NULL
        AND job_title Like '%Data Analyst%'
        AND job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_paying_jobs.*,
    skills_dim.skills
FROM top_paying_jobs
    Inner JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
    Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
