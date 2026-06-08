
WITH top_intern_jobs AS(
SELECT
     job_title,
     skills,
     salary_hour_avg
FROM
    job_postings_fact AS job_postings
LEFT JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_title LIKE '%Intern%' AND 
salary_hour_avg IS NOT NULL AND
salary_hour_avg > 45

ORDER BY salary_hour_avg DESC

LIMIT 500
)

SELECT
    skills,
    COUNT (skills) AS amount_of_jobs

FROM
    top_intern_jobs
GROUP BY skills
ORDER BY amount_of_jobs DESC;

/*
TOP SKILLS FOR DATA INTERNSHIPS WITH HOURLY RATE OF 45+ dolalr
Core Skills (Most Valuable)
These dominate internship postings and should be priorities:
Python (36)
SQL (33)
R (16)
SAS (12)
Spark (10)
*/

WITH skills_demand AS(
    SELECT
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER jOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
    GROUP BY
        skills
    ORDER BY 
        demand_count DESC
    LIMIT 5)
    ;