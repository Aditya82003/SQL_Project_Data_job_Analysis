/*
=========================================================
QUESTION:
What are the highest-paying skills for Data Analysts?

GOAL:
Identify the top 25 skills associated with the highest
average yearly salaries in Data Analyst job postings.

APPROACH:
1. Filter job postings for Data Analyst roles with specified
   yearly salaries.
2. Join job postings with the skills tables to identify
   the skills required for each job.
3. Calculate the average yearly salary for each skill.
4. Round the average salary to the nearest whole number.
5. Sort skills by average salary in descending order.
6. Return the top 25 highest-paying skills.

=========================================================
*/


SELECT 
        skills_dim.skills,
    Round(AVG(salary_year_avg),0) AS salary
FROM job_postings_fact
    Inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skills
ORDER BY
    salary DESC
LIMIT
    25