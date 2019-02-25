1.)  --Query UTM Campaign Lookup--
SELECT DISTINCT utm_campaign
FROM page_visits;


2.) --Query UTM Source Lookup--
SELECT DISTINCT utm_campaign
FROM page_visits;

3.) --Query Campaign and Source Relationship--

SELECT DISTINCT utm_campaign, 
				utm_source
FROM page_visits;
 

4.) --Query Website Page Names--
SELECT DISTINCT page_name
FROM page_visits;

5.) --Query First Touch Counts--
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
    COUNT(ft.first_touch_at),
    pv.utm_campaign,
    pv.utm_source
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY 2
ORDER BY 1 DESC;


6.) --Query Last Touch Counts--

WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
    COUNT(ft.last_touch_at),
		pv.utm_campaign,
    pv.utm_source
FROM last_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.last_touch_at = pv.timestamp
    GROUP BY 2
ORDER BY 1 DESC; 

7.) --Query Total Visitor Purchases--
SELECT DISTINCT COUNT (user_id),page_name
FROM page_visits
WHERE page_name = '4 - purchase';

8.)-- Query How many purchases each Campaign is responsible for--
 WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT 
    COUNT(ft.last_touch_at),
		pv.utm_campaign
FROM last_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.last_touch_at = pv.timestamp
WHERE pv.page_name ='4 - purchase'
GROUP BY 2
ORDER BY 1 DESC;



