--Sleep Data that is going to be used
Select *
FROM ProjectSleep.dbo.Sleep
ORDER by 1

--Gender relationship to sleep duration and sleep efficiency
Select Gender,[Sleep duration], [Sleep efficiency]
FROM ProjectSleep.dbo.Sleep
WHERE Gender = 'Male'

Select Gender,[Sleep duration], [Sleep efficiency]
FROM ProjectSleep.dbo.Sleep
WHERE Gender = 'Female'

--Average sleep duration and efficiency by gender

Select Gender, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep
WHERE Gender = 'Female'
GROUP BY Gender

Select Gender, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep
WHERE Gender = 'Male'
GROUP BY Gender

--Age relationship to sleep

Select Age, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep
WHERE Age <= 44
GROUP BY Age

Select Age, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep
WHERE Age >= 45
GROUP BY Age




  SELECT Age, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency,
    CASE  
      WHEN age >60  THEN '60 And Up'
      WHEN age >=41 and age <=60 THEN '41-60'
      WHEN age >=21 and age <=40 THEN '21-40'
      WHEN age <=20 THEN '20 And Below' 
    END as [Age Range]
  from ProjectSleep.dbo.Sleep
group by [Age]

--Copy to look at

SELECT emp.agerange as [age Range],
   count(*) as [Number of employee on this age range],
   SUM(Salary) AS "Total Salary",  
   AVG(Salary) AS "Average Salary",
   100 * COUNT(*) / SUM(COUNT(*)) OVER () AS "% of employees in this range"
FROM
 (
  SELECT Salary,
    CASE  
      WHEN age >60  THEN '60 And Up'
      WHEN age >=41 and age <=60 THEN '41-60'
      WHEN age >=21 and age <=40 THEN '21-40'
      WHEN age <=20 THEN '20 And Below' 
    END as agerange
  from kin.dbo.Employee
 ) emp
group by emp.agerange

 SELECT Age, AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency,
		SUM(CASE WHEN Age < 20 THEN 1 ELSE 0 END) AS [Under 20],
        SUM(CASE WHEN Age BETWEEN 20 AND 40 THEN 1 ELSE 0 END) AS [20-40],
        SUM(CASE WHEN Age BETWEEN 41 AND 60 THEN 1 ELSE 0 END) AS [41-60],
		SUM(CASE WHEN Age > 60 THEN 1 ELSE 0 END) AS [Over 60]
 FROM ProjectSleep.dbo.Sleep
 group by Age

  SELECT COUNT(*) AS TOTAL, Age_Range
  FROM
  (
  SELECT
	CASE
		WHEN Age < 20 THEN 'Under 20'
        WHEN Age BETWEEN 20 AND 40 THEN '20-40'
        WHEN Age BETWEEN 41 AND 60 THEN '41-60'
		WHEN Age > 60 THEN 'Over 60'
	END as Age_Range
	FROM ProjectSleep.dbo.Sleep
 ) t
 group by Age_Range
 ORDER BY Age_Range

 --Exercise and sleep

 Select [Exercise frequency], AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep

GROUP BY [Exercise frequency]

--Caffeine and sleep

 Select [Caffeine consumption], AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep

GROUP BY [Caffeine consumption]

--Alcohol and sleep

 Select [Alcohol consumption], AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep

GROUP BY [Alcohol consumption]

--Smoking and sleep

 Select [Smoking status], AVG([Sleep duration]) AS AVG_Sleep_Duration, AVG([Sleep efficiency]) AS AVG_Sleep_Efficiency
FROM ProjectSleep.dbo.Sleep

GROUP BY [Smoking status]

--Cleaning null

 Select ID, [Exercise frequency]
FROM ProjectSleep.dbo.Sleep
WHERE [Exercise frequency] is null



select *,
      coalesce(cast([exercise frequency] as varchar(255)), 'N/A') as Clean_Ex_Frequency,
	  coalesce(cast([Awakenings] as varchar(255)), 'N/A') as Clean_Awakenings,
	  coalesce(cast([Caffeine consumption] as varchar(255)), 'N/A') as Clean_Caffeine_Consumption,
	  coalesce(cast([Alcohol consumption] as varchar(255)), 'N/A') as Clean_Alcohol_Consumption
from ProjectSleep.dbo.Sleep
