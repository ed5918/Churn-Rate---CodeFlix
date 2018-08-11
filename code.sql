 SELECT *
 FROM subscriptions 
 LIMIT 100;

//////////////


SELECT MIN(subscription_start) AS START , MAX(subscription_start) AS END
FROM subscriptions;

////////

WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as end_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as end_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-30' as end_day)
 SELECT *
 FROM subscriptions;

//////////////////////////

 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months)
 SELECT *
 FROM cross_join;
 

////////////

 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months),
 status AS
 (SELECT id, first_day AS month ,
CASE
WHEN (subscription_start < first_day)
 AND (subscription_end > first_day
 OR subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_82,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_30
 FROM cross_join)
 SELECT *
 FROM status;
////////////////////////////


 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months),
 status AS
 (SELECT id, first_day AS month ,
CASE
WHEN (subscription_start < first_day)
 AND (subscription_end > first_day
 OR subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_87,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_30,
 CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_87,
   CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_30
 FROM cross_join)
  SELECT *
  FROM status;

///////////


 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months),
 status AS
 (SELECT id, first_day AS month ,
CASE
WHEN (subscription_start < first_day)
 AND (subscription_end > first_day
 OR subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_87,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_30,
 CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_87,
   CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_30
 FROM cross_join),
status_aggregate  AS
 (SELECT month,
  SUM(is_active_87) AS  sum_active_87,
  SUM(is_active_30) AS  sum_active_30,
  SUM(is_canceled_87) AS sum_canceled_87,
  SUM(is_canceled_30) AS sum_canceled_30
  FROM status
 GROUP BY month)
  SELECT *
  FROM status_aggregate;
///////


 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months),
 status AS
 (SELECT id, first_day AS month ,
CASE
WHEN (subscription_start < first_day)
 AND (subscription_end > first_day
 OR subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_87,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_30,
 CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_87,
   CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_30
 FROM cross_join),
status_aggregate  AS
 (SELECT month,
  SUM(is_active_87) AS  sum_active_87,
  SUM(is_active_30) AS  sum_active_30,
  SUM(is_canceled_87) AS sum_canceled_87,
  SUM(is_canceled_30) AS sum_canceled_30
  FROM status
 GROUP BY month)
 SELECT month,
 1.0 * sum_canceled_87/sum_active_87 AS churn_rate_87,
 1.0 * sum_canceled_30/sum_active_30 AS churn_rate_30
FROM status_aggregate
GROUP BY month;



/////////////////


 WITH months AS
(SELECT
'2017-01-01' as first_day,
'2017-01-31' as last_day
UNION
SELECT
 '2017-02-01' as first_day,
 '2017-02-28' as last_day
 UNION
 SELECT
 '2017-03-01' as first_day,
 '2017-03-31' as last_day),
 cross_join AS 
 (SELECT *
 FROM subscriptions 
 CROSS JOIN months),
 status AS
 (SELECT id, first_day AS month ,
CASE
WHEN (subscription_start < first_day)
 AND (subscription_end > first_day
 OR subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_87,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_30,
 CASE
  WHEN
  (subscription_start < first_day)
 AND (subscription_end > first_day)
 OR (subscription_end IS NULL)
 THEN 1
 ELSE  0
 END is_active_50,
 CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_87,
   CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_30,
  CASE
  WHEN subscription_end BETWEEN first_day
        AND last_day
   THEN 1
   ELSE 0
   END is_canceled_50
 FROM cross_join),
status_aggregate  AS
 (SELECT month,
  SUM(is_active_87) AS  sum_active_87,
  SUM(is_active_30) AS  sum_active_30,
  SUM(is_active_50) AS  sum_active_50,
  SUM(is_canceled_87) AS sum_canceled_87,
  SUM(is_canceled_50) AS sum_canceled_50,
  SUM(is_canceled_30) AS sum_canceled_30
  FROM status
 GROUP BY month)
 SELECT month,
 1.0 * sum_canceled_87/sum_active_87 AS churn_rate87,
 1.0 * sum_canceled_50/sum_active_50 AS churn_rate_50,
 1.0 * sum_canceled_30/sum_active_30 AS churn_rate_30
 FROM status_aggregate
GROUP BY month;
