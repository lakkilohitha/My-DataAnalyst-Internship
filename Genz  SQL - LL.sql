select * from genz;
   describe genz;
ALTER TABLE Genz 
  MODIFY COLUMN Time_Stamp datetime,
    MODIFY COLUMN Country VARCHAR(50),
    MODIFY COLUMN `Zip Code` VARCHAR(10),
    MODIFY COLUMN Gender  VARCHAR(10),
    MODIFY COLUMN Influencers VARCHAR(255),
    MODIFY COLUMN HigherEdu VARCHAR(255),
    MODIFY COLUMN 3year_tenurity VARCHAR(255),
    MODIFY COLUMN Undefined_Missions VARCHAR(255),
    MODIFY COLUMN Willingness_towork_withmisalligned_companies  VARCHAR(255),
    MODIFY COLUMN Socially_impactless VARCHAR(255),
    MODIFY COLUMN Work_Environment VARCHAR(255),
    MODIFY COLUMN `Which of the below Employers would you work with.` VARCHAR(255),
    MODIFY COLUMN Learning_Environment VARCHAR(255),
    MODIFY COLUMN Career_Aspirations VARCHAR(255),
    MODIFY COLUMN Taskby_Manager VARCHAR(255),
    MODIFY COLUMN `Team Setup` VARCHAR(255),
    MODIFY COLUMN `Evaluating Job Opportunities Post-Layoffs` VARCHAR(255),
    MODIFY COLUMN 7years_Tenurity  VARCHAR(255),
    MODIFY COLUMN Email VARCHAR(100),
    MODIFY COLUMN Salary_after3years VARCHAR(20),
    MODIFY COLUMN Salary_after5years VARCHAR(20),
    MODIFY COLUMN Noremote_policies INT,
    MODIFY COLUMN Expectationsof_salary VARCHAR(20),
    MODIFY COLUMN `Ideal Company Characteristics`VARCHAR(255),
    MODIFY COLUMN AbusiveLeadership_on_carrerdecisions VARCHAR(255),
    MODIFY COLUMN `Working Hours`  VARCHAR(50),
    MODIFY COLUMN Worklife_Balance VARCHAR(50),
    MODIFY COLUMN Workplace_Happiness VARCHAR(255),
    MODIFY COLUMN Frustrations VARCHAR(255);
----------------------------------------------------------------------------------------------------
-- Q1 : What is the gender distribution of respondents from India?
SELECT Gender,country FROM genz 
WHERE country = "India" ; 
----------------------------------------------------------------------------------------------------
-- Q2 : What percentage of respondents from India are interested in education abroad and sponsorship?
SELECT Country, HigherEdu, COUNT(email) AS email_count,
    ROUND((COUNT(email) * 100.0 / (SELECT COUNT(*) FROM genz WHERE HigherEdu IN ('Yes', 'Need a Sponsors') AND Country = 'India')), 2) AS percentage
FROM genz
WHERE Country = 'India'
GROUP BY Country, HigherEdu
ORDER BY HigherEdu  desc;
----------------------------------------------------------------------------------------------------
-- Q3 : What are the 6 top influences on career aspirations for respondents in India?
SELECT Country,COUNT(Influencers), Influencers FROM genz 
WHERE Country = "India" 
GROUP BY Influencers
ORDER BY COUNT(Influencers)  DESC Limit 6;
----------------------------------------------------------------------------------------------------
-- Q4 : How do career aspiration influences vary by gender in India?
SELECT Country,Gender,COUNT(Influencers), Influencers FROM genz 
WHERE Country = "India" 
GROUP BY Influencers,Gender
ORDER BY COUNT(Influencers) Desc ;
----------------------------------------------------------------------------------------------------
-- Q5 : What percentage of respondents are willing to work for a company for at least 3 years?
SELECT 3year_tenurity, COUNT(email) AS email_count,
    ROUND((COUNT(email) * 100.0 / SUM(COUNT(email)) OVER ()), 2) AS percentage
FROM genz
WHERE 3year_tenurity IN ('yes', 'Depends on company culture')
GROUP BY 3year_tenurity;
----------------------------------------------------------------------------------------------------
-- Q6 : How many respondents prefer to work for socially impactful companies?
SELECT Socially_impactless, COUNT(email) FROM genz
GROUP BY Socially_impactless
ORDER BY Socially_impactless ASC;
----------------------------------------------------------------------------------------------------
-- Q7 :  How does the preference for socially impactful companies vary by gender?
SELECT Socially_impactless, COUNT(Socially_impactless),Gender FROM genz
GROUP BY Socially_impactless,Gender
ORDER BY Socially_impactless ASC;
----------------------------------------------------------------------------------------------------
-- Q8 : What is the distribution of minimum expected salary in the first three years among respondents?
SELECT Salary_after3years,COUNT(Salary_after3years) FROM genz 
GROUP BY Salary_after3years
ORDER BY COUNT(Salary_after3years) DESC; 
----------------------------------------------------------------------------------------------------
-- Q9 : What is the expected minimum monthly salary in hand?
SELECT Expectationsof_salary,COUNT(Expectationsof_salary) FROM genz
GROUP BY Expectationsof_salary
ORDER BY COUNT(Expectationsof_salary) DESC LIMIT 5 Offset 1 ;
----------------------------------------------------------------------------------------------------
-- Q10 : What percentage of respondents prefer remote working?
WITH PolicyCounts AS (
    SELECT Noremote_policies, COUNT(email) AS email_count
    FROM genz
    GROUP BY Noremote_policies
)
SELECT 
    Noremote_policies, 
    email_count,
    ROUND((email_count * 100.0 / SUM(email_count) OVER ()), 2) AS percentage
FROM PolicyCounts
ORDER BY Noremote_policies ASC;
----------------------------------------------------------------------------------------------------
-- Q11 : What is the preferred number of daily work hours?
SELECT `Working Hours`,COUNT(`Working Hours`) FROM genz
GROUP BY `Working Hours`
ORDER BY COUNT(`Working Hours`) DESC LIMIT 5 OFFSET 1;
----------------------------------------------------------------------------------------------------
-- Q12 : What are the common work frustrations among respondents?
SELECT Frustrations,COUNT(Frustrations) FROM genz
GROUP BY Frustrations 
ORDER BY COUNT(Frustrations) DESC LIMIT 7 OFFSET 1;
----------------------------------------------------------------------------------------------------
-- Q13 : How does the need for work-life balance interventions vary by gender?
SELECT Worklife_Balance,Gender,COUNT(Worklife_Balance) FROM genz
GROUP BY Worklife_Balance, Gender
ORDER BY COUNT(Worklife_Balance) DESC LIMIT 12 Offset 2;
----------------------------------------------------------------------------------------------------
-- Q14 : How many respondents are willing to work under an abusive manager?
SELECT AbusiveLeadership_on_carrerdecisions,COUNT(AbusiveLeadership_on_carrerdecisions) AS Willing_Respondents  FROM genz
WHERE AbusiveLeadership_on_carrerdecisions LIKE "yes"
GROUP BY AbusiveLeadership_on_carrerdecisions;
----------------------------------------------------------------------------------------------------
-- Q15 : What is the distribution of minimum expected salary after five years?
SELECT Salary_after5years,COUNT(Salary_after5years) FROM genz
GROUP BY Salary_after5years 
ORDER BY Salary_after5years DESC;
----------------------------------------------------------------------------------------------------
-- Q16 : What are the remote working preferences by gender?
SELECT Noremote_policies,COUNT(email),Gender FROM genz 
WHERE Noremote_policies LIKE "0"
GROUP BY Noremote_policies,Gender
ORDER BY Noremote_policies ASC;
----------------------------------------------------------------------------------------------------
-- Q17 : What are the top work frustrations for each gender?
SELECT Frustrations,COUNT(Frustrations),Gender FROM genz
GROUP BY Frustrations,Gender
ORDER BY COUNT(Frustrations) DESC LIMIT 7 OFFSET 2;
----------------------------------------------------------------------------------------------------
-- Q18 : What factors boost work happiness and productivity for respondents?
SELECT Workplace_Happiness,COUNT(Workplace_Happiness) FROM genz
GROUP BY Workplace_Happiness
ORDER BY COUNT(Workplace_Happiness) DESC LIMIT 6 OFFSET 1 ;
----------------------------------------------------------------------------------------------------
-- Q19 : What percentage of respondents need sponsorship for education abroad?
SELECT Country, HigherEdu, COUNT(email) AS email_count,
    ROUND((COUNT(email) * 100.0 / (SELECT COUNT(*) FROM genz WHERE HigherEdu IN ('Yes', 'Need a Sponsors') AND Country = 'India')), 2) AS percentage
FROM genz
WHERE Country = 'India'
GROUP BY Country, HigherEdu
ORDER BY HigherEdu ASC Limit 1;
----------------------------------------------------------------------------------------------------
















    
    












