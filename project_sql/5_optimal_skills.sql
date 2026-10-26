
/*
=========================================================
QUESTION:
What are the optimal skills for remote Data Analyst jobs
based on demand and salary?

GOAL:
Identify the top 25 optimal skills by balancing skill demand
and average yearly salary in remote Data Analyst job postings.

APPROACH:
1. Filter remote Data Analyst jobs with specified yearly salaries.
2. Calculate the demand for each skill based on the number
   of associated job postings.
3. Calculate the average yearly salary for each skill.
4. Round average salaries to the nearest whole number.
5. Combine skill demand and salary data using CTEs.
6. Rank skills by demand in descending order, followed by
   average salary in descending order.
7. Return the top 25 skills.

=========================================================
*/



WITH skills_demand AS (
    SELECT skills_dim.skill_id,
        count(job_postings_fact.job_id) AS demand_count,
        skills_dim.skills
    FROM job_postings_fact
        Inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
),
average_salary AS (
    SELECT skills_dim.skill_id,
        skills_dim.skills,
        Round(AVG(salary_year_avg), 0) AS salary
    FROM job_postings_fact
        Inner JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        Inner JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY skills_dim.skill_id
)
SELECT 
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    salary AS average_salary

from skills_demand
    Inner JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY
    salary DESC,
    demand_count DESC
LIMIT
    25