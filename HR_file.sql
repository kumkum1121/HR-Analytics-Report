Create database HR;

SHOW databases;

USE HR;

DESCRIBE hr_csv;

SELECT * from hr_csv limit 20;

-- Total number of Employees 
Select count('Employee Number') 
as "Total Employees" from hr_csv;

-- Total Number of Employees who Left Job (Total Attrition)
Select sum(`CF_attrition count`) 
as Attrition from hr_csv;

-- Total Number of Active Employees 
Select count("Employee Number")-sum(`CF_attrition count`) 
as "Active Employees" from hr_csv;

-- Total Attrition Rate 
select round((sum(`CF_attrition count`)/count('Employee Number')*100),2) 
As "Attrition Rate" from hr_csv; 

-- Average Age
Select round(avg(`Age`)) from hr_csv;

-- Job Satisfaction rate
select round((avg(`Job Satisfaction`)),1) 
As "Job Satisfaction Rate" from hr_csv;

-- High Performance Status 
Select Performance_Status,count(`Employee Number`) as Total_Employees  from hr_csv
where Performance_Status="High";

-- Low Performance Status 
Select Performance_Status,count(`Employee Number`) as Total_Employees  from hr_csv
where Performance_Status="Low";

-- Distance_Status
Select Distance_Status,count(`Employee Number`) as Total_Employees  from hr_csv
Group by Distance_Status;


-- Total Employee by Gender
Select Gender ,count(`Employee Number`) as Total_Employees from hr_csv
group by Gender;

-- Education Wise Attrition 
Select Education ,Sum(`CF_attrition count`) as Attrition from hr_csv
group by Education
Order by Sum(`CF_attrition count`) Desc;

-- Attrition by Job Role 
Select sum(`CF_attrition count`) as Attrition,`Job Role`  from hr_csv
group by `Job Role`
Order by sum(`CF_attrition count`) Desc;

-- Department wise Attrition
Select Department,
SUM(`CF_attrition count`) as "Attrition",
Concat(round(SUM(`CF_attrition count`)/(SELECT SUM(`CF_attrition count`) FROM hr_csv) * 100),"%") 
as "Attrition in %"  
from hr_csv
group by Department
Order by sum(`CF_attrition count`) Desc;

-- Attrition by Age_Group
Select sum(`CF_attrition count`) as Attrition,`CF_age band`  from hr_csv
group by `CF_age band`
Order by sum(`CF_attrition count`) Desc;

-- Attrition by Marital Status
Select sum(`CF_attrition count`) as Attrition,`Marital Status`  from hr_csv
group by `Marital Status`
Order by sum(`CF_attrition count`) Desc;
 
DESCRIBE hr_csv;

-- ####Add new column using existing Columns####
-- Distance Status 
Alter Table hr_csv
ADD COLUMN Distance_Status VARCHAR(25);

UPDATE hr_csv
SET Distance_Status = CASE 
    WHEN `Distance From Home` <= 20 THEN 'Near'
    WHEN `Distance From Home` <= 30 THEN 'Far'
    ELSE 'Very_Far'
END;

-- Total Working Year
Alter Table hr_csv
ADD COLUMN Working_Year_Group VARCHAR(25);

UPDATE hr_csv
SET Working_Year_Group = CASE 
    WHEN `Total Working Years` <= 10 THEN '0-10'
    WHEN `Total Working Years` <= 30 THEN '11-20'
    WHEN `Total Working Years` <= 30 THEN '21-30'
    ELSE '31+'
END;

-- Performance Status
Alter Table hr_csv
ADD COLUMN Performance_Status VARCHAR(25);

UPDATE hr_csv
SET Performance_Status= CASE 
    WHEN `Performance Rating` <=3 THEN 'Low'
    ELSE 'High'
END;












 

