/*
based off salary year avg above 150,000 jobs
how many jobs above ^
*/


WITH top_skills AS(
SELECT
    job_postings.job_id,
    job_postings.salary_year_avg,
    job_title,
    skills

FROM
    job_postings_fact AS job_postings
LEFT JOIN
    skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
LEFT JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE job_postings.salary_year_avg IS NOT NULL AND
      job_postings.salary_year_avg > 150000
)

SELECT
    skills_dim.skills,
    COUNT(skills_dim.skills) AS job_count
    

FROM top_skills
INNER JOIN skills_job_dim ON top_skills.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

GROUP BY skills_dim.skills

ORDER BY job_count DESC

LIMIT 10;

/*
average salary
for data analyst roles, highest paying skills
*/

SELECT
   skills,
   ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE 
   job_title_short = 'Data Analyst'
   AND salary_year_avg IS NOT NULL 
   AND job_work_from_home = TRUE
   

GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25