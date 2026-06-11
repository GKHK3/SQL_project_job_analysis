# Introduction
**Top skills for Data Scientist roles based on salary and demand of jobs.**

SQL queries? Check them out here [project_sql_folder](/project_sql/)
# Background
blah blah

1. What are the top-paying Data Scientist roles?
2. What are the skills required for top-paying Data Scientist roles?
3. What are the top demanded skills for Data Scientist roles?
4. What are the Top paying skills for Data Scientist jobs?
5. What are the most optimal skills to learn? (Pay and Demand)
# Tools used
- **SQL**: 
- **PostgresQL**: 
- **Git & GitHub**: 
# Analysis
blah blah
### 1. Top Paying Data Scientist Jobs
blah blah

![Top_Paying_Roles](assets/Top_10_Data_Scientists_Salaries.png)
*chatgpt generated it*

blah blah

```sql
SELECT
    job_id,
    job_title,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE job_title = 'Data Analyst' AND 
      job_location = 'Anywhere' AND
      job_work_from_home = TRUE AND
      salary_year_avg IS NOT NULL
ORDER BY
      salary_year_avg DESC
LIMIT 10
```


### 2. Skills Required for top-paying Data Scientist roles
blah blah

![top_highest_paying_skills](assets/top10_highest_skill_pay.png)
*chatgpt generated it*


```sql
WITH top_paying_jobs AS(
SELECT
    job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id

WHERE job_title = 'Data Scientist' AND 
      job_location = 'Anywhere' AND
      salary_year_avg IS NOT NULL
ORDER BY
      salary_year_avg DESC
LIMIT 10
)

SELECT
      top_paying_jobs.*,
      skills
FROM top_paying_jobs
INNER JOIN skills_job_dim AS skills_job ON top_paying_jobs.job_id = skills_job.job_id
INNER JOIN skills_dim ON skills_job.skill_id = skills_dim.skill_id

ORDER BY  top_paying_jobs.salary_year_avg DESC
```

### 3. Most Demanded Skills
blah blah

blah blah
| Rank | Skill   | Job Count |
| :--: | :------ | -----------: |
|   1  | Python  |       10,390 |
|   2  | SQL     |        7,488 |
|   3  | R       |        4,674 |
|   4  | AWS     |        2,593 |
|   5  | Tableau |        2,458 |

```sql
    SELECT
        skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER jOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Scientist'
        AND job_work_from_home = TRUE
    GROUP BY
        skills
    ORDER BY 
        demand_count DESC
    LIMIT 5
```

### 4. Skills that Pay the Most
blah blah

| Rank | Skill         | Average Salary (USD) |
| :--: | :------------ | -------------------: |
|   1  | GDPR          |             $217,738 |
|   2  | Golang        |             $208,750 |
|   3  | Atlassian     |             $189,700 |
|   4  | Selenium      |             $180,000 |
|   5  | OpenCV        |             $172,500 |
|   6  | Neo4j         |             $171,655 |
|   7  | MicroStrategy |             $171,147 |
|   8  | DynamoDB      |             $169,670 |
|   9  | PHP           |             $168,125 |
|  10  | Tidyverse     |             $165,513 |
|  11  | Solidity      |             $165,000 |
|  12  | C             |             $164,865 |
|  13  | Go            |             $164,691 |
|  14  | DataRobot     |             $164,500 |
|  15  | Qlik          |             $164,485 |
|  16  | Redis         |             $162,500 |
|  17  | Watson        |             $161,710 |
|  18  | Rust          |             $161,250 |
|  19  | Elixir        |             $161,250 |
|  20  | Cassandra     |             $160,850 |
|  21  | Looker        |             $158,715 |
|  22  | Slack         |             $158,333 |
|  23  | Terminal      |             $157,500 |
|  24  | Airflow       |             $157,414 |
|  25  | Julia         |             $157,244 |

```sql
SELECT
   skills,
   ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM job_postings_fact AS job_postings
INNER JOIN skills_job_dim ON job_postings.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id

WHERE 
   job_title_short = 'Data Scientist'
   AND salary_year_avg IS NOT NULL 
   AND job_work_from_home = TRUE
   

GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25
```
blahblah


### 5. Most optimal skills for Data Scientists
blah

![Top_15_skills](assets/Top_15_Data_Scientist_Skills.png)


```sql
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(skills_job_dim.job_id) AS demand_count,
     ROUND(AVG(salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER jOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Scientist'
    AND job_country = 'United States'
    AND salary_year_avg IS NOT NULL 
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING COUNT(skills_job_dim.job_id) > 10
ORDER BY 
   avg_salary DESC,
   demand_count DESC
LIMIT 25
```
blah blah

# What I learned
hello test 123
# Conclusions
