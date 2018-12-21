--the number of distinct campaigns
SELECT COUNT(DISTINCT utm_campaign) as Total_Campaigns FROM page_visits;

--the number of distinct sources
SELECT COUNT(DISTINCT utm_source) as Total_Sources FROM page_visits;

--how they are related
SELECT DISTINCT utm_campaign as Campaign, utm_source as Source
FROM page_visits;

--What pages are on the CoolTShirts website?
SELECT DISTINCT page_name FROM page_visits;

--How many first touches is each campaign responsible for?
WITH first_touch AS (
    SELECT user_id,
        MIN(timestamp) as first_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as Campaign, COUNT(ft.first_touch_at) as First_Touches
FROM first_touch ft
JOIN page_visits pv
    ON ft.user_id = pv.user_id
    AND ft.first_touch_at = pv.timestamp
    GROUP BY 1
    ORDER BY 2 DESC;

--How many last touches is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as Campaign, COUNT(lt.last_touch_at) as Last_Touches
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
    GROUP BY 1
    ORDER BY 2 DESC;

--How many visitors make a purchase?
SELECT COUNT(DISTINCT user_id) as prchs_visitors FROM page_visits WHERE page_name = '4 - purchase';

--How many last touches on the purchase page is each campaign responsible for?
WITH last_touch AS (
    SELECT user_id,
        MAX(timestamp) as last_touch_at
    FROM page_visits
    GROUP BY user_id)
SELECT pv.utm_campaign as Campaign, COUNT(lt.last_touch_at) as prchs_lt
FROM last_touch lt
JOIN page_visits pv
    ON lt.user_id = pv.user_id
    AND lt.last_touch_at = pv.timestamp
WHERE page_name ='4 - purchase'
GROUP BY 1
ORDER BY 2 DESC;

