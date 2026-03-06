##Bellabeat Case Study
##Author: Ebunoluwa Adejumo
##Tool: Google BigQuery
##Dataset: Bellabeat Smart Device Data

##View the dataset
SELECT * 
FROM 
my-project-78009-485004.Bellabeat.Daily_activity;

##Check number of users
SELECT COUNT(DISTINCT Id) AS total_users
FROM my-project-78009-485004.Bellabeat.Daily_activity;

##Daily average steps overtime
SELECT 
Activity_Date,
AVG(total_steps) AS avg_daily_steps
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_Date
ORDER BY Activity_Date;

##Are average steps consistently lower on specific weekdays and higher on weekends?
SELECT
  FORMAT_DATE('%A', Activity_Date) AS weekday,
  AVG(Total_steps) AS avg_steps
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY weekday
ORDER BY avg_steps DESC;

##Calculates the average sedentary minutes and average calories burned per day across all users over time.
SELECT 
  Activity_Date,
  AVG(Sedentary_Minutes) AS avg_sedentary,
  AVG(Calories) AS avg_calories
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_Date
ORDER BY Activity_Date DESC;

## Extract unique daily activity records for each user to examine
## step counts and distance covered, ordered by user and latest activity date.
SELECT DISTINCT
  Id,
  Activity_Date,
  Total_steps,
  Total_Distance
FROM my-project-78009-485004.Bellabeat.Daily_activity
ORDER BY Id, Activity_Date DESC;

##Identify records where users recorded no steps and no distance,
SELECT
  Id, Activity_Date, Total_steps, Total_Distance
FROM my-project-78009-485004.Bellabeat.Daily_activity
WHERE NOT Total_steps > 0 AND Total_Distance = 0
ORDER BY Activity_Date DESC;

##Identifying inconsistent rows
SELECT
  COUNT(*) AS inconsistent_rows
FROM my-project-78009-485004.Bellabeat.Daily_activity
WHERE Total_steps > 0 AND Total_Distance = 0;


##Analyze whether users are more active on weekdays or weekends
##by comparing average daily step counts.
SELECT
  CASE 
    WHEN FORMAT_DATE('%A', Activity_Date) IN ('Saturday', 'Sunday')
      THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  AVG(Total_steps) AS avg_steps
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY day_type; 


##Is sedentary time trending upward over time
SELECT 
Activity_date, 
AVG(Sedentary_Minutes) AS avg_sedentary_minutes
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_date
ORDER BY Activity_date DESC; 

##Is Average calorie burn trending upward or downward over time?
SELECT 
Activity_date,
AVG(Calories) AS avg_calorie
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_Date
ORDER By Activity_Date; 

##Is Average Active minutes trending upward or downward?
SELECT
  Activity_Date,
  AVG(Very_Active_Minutes) AS avg_very_active_minutes
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_Date
ORDER BY Activity_Date;

## Distribution of activity Level
SELECT
  Activity_Date,
  AVG(Very_Active_Minutes) AS avg_very_active,
  AVG(Fairly_Active_Minutes) AS avg_fairly_active,
  AVG(Lightly_Active_Minutes) AS avg_lightly_active
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_Date
ORDER BY Activity_Date;

## Analyze user participation stable over time?
SELECT
Activity_date,
COUNT(id) AS Active_users
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_date
ORDER BY Activity_Date;

## Is Behavioral Variability Increasing?
SELECT
  Activity_date,
  STDDEV(Total_steps) AS step_variability
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Activity_date
ORDER BY Activity_date;

##Is there a correlation between calorie and total steps 
SELECT
  CORR(Total_steps, Calories) AS step_calorie_corr
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Id
ORDER BY step_calorie_corr DESC;

##Is there a correlation between calorie and total steps per user
SELECT
  Id,
  CORR(Total_steps, Calories) AS step_calorie_corr
FROM my-project-78009-485004.Bellabeat.Daily_activity
GROUP BY Id
ORDER BY step_calorie_corr DESC;

