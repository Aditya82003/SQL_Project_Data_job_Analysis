
/*
=========================================================
QUESTION:
What are the most demanded skills for Data Analysts?

GOAL:
Identify the top 5 most demanded skills for Data Analyst
job postings based on the number of job postings requiring
each skill.

APPROACH:
1. Filter job postings for the Data Analyst role.
2. Join job postings with the skills tables to identify
   the skills required for each job.
3. Count the number of job postings associated with each skill.
4. Group the results by skill.
5. Sort skills by demand count in descending order.
6. Return the top 5 most demanded skills.

=========================================================
*/



SELECT 
    count(job_postings_fact.job_id) AS demand_count,
    skills_dim.skills
FROM job_postings_fact
    Inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst'
GROUP BY 
    skills_dim.skills
ORDER BY
    count(job_postings_fact.job_id) DESC
LIMIT 
    5