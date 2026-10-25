/*
=========================================================
-- Question : What are the top paying data analyst job?

-- Goal : Find the top 10 highest-paying Data Analyst jobs.

Approach:
1. Indentify the top 10 data analyst job that are available remotely.
2. Focus on the jobs posting with specified salary.
3. Sort jobs by average yearly salary in descending order.
4. Return the top 10 highest paying data analyst jobs.

=========================================================
*/
select 
    job_id,
    company_dim.name AS company_name,
    job_title,
    job_location,
    job_schedule_type,
    job_posted_date::Date,
    salary_year_avg
from 
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    salary_year_avg IS NOT NULL
    AND job_title Like '%Data Analyst%'
    AND job_location = 'Anywhere'
ORDER BY
    salary_year_avg DESC
LIMIT
    10


