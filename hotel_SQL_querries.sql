-- Creating a temporary table Hotels that combines data from all three years
with Hotels as (
select *
FROM dbo.[2018_revenue]
union
SELECT *
FROM dbo.[2019_revenue]
union
SELECT *
FROM dbo.[2020_revenue])
--Joining two tables:market_segement and meal to the temporary table Hotels
SELECT *
FROM Hotels
LEFT JOIN dbo.market_segment m
on hotels.market_segment = m.market_segment
LEFT JOIN dbo.meal_cost meal
on hotels.meal=meal.meal


-- Calculating revenue by year on given hotel 
with hotels as (
select *
FROM dbo.[2018_revenue]
union
SELECT *
FROM dbo.[2019_revenue]
union
SELECT *
FROM dbo.[2020_revenue])
SELECT hotel, arrival_date_year, round(SUM((stays_in_weekend_nights + stays_in_week_nights)*adr),2) as revenue
FROM hotels
GROUP BY hotel, arrival_date_year
ORDER BY revenue 

-- Do we need more car parking?
with hotels as (
select *
FROM dbo.[2018_revenue]
union
SELECT *
FROM dbo.[2019_revenue]
union
SELECT *
FROM dbo.[2020_revenue])
SELECT arrival_date_year,SUM(required_car_parking_spaces) as total_parking
FROM Hotels
GROUP BY arrival_date_year, required_car_parking_spaces

--Which month was the busiest
with Hotels as (
select *
FROM dbo.[2018_revenue]
union
SELECT *
FROM dbo.[2019_revenue]
union
SELECT *
FROM dbo.[2020_revenue])
SELECT arrival_date_month, arrival_date_year, COUNT(arrival_date_month)
FROM Hotels
GROUP BY arrival_date_month, arrival_date_year
ORDER BY arrival_date_year, COUNT(arrival_date_month)

with Hotels as (
select *
FROM dbo.[2018_revenue]
union
SELECT *
FROM dbo.[2019_revenue]
union
SELECT *
FROM dbo.[2020_revenue])
SELECT SUM(stays_in_week_nights), sum(stays_in_weekend_nights)
FROM Hotels