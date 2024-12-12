CREATE DATABASE phone;
USE phone;
SELECT * FROM smartphones;
#SELECT * FROM SMARTPHONES WHERE 1;
#SELECT MODEL,PRICE,RATING FROM SMARTPHONES;
SELECT MODEL,
sqrt((RESOLUTION_WIDTH*RESOLUTION_WIDTH + RESOLUTION_HEIGHT*RESOLUTION_HEIGHT)/SCREEN_SIZE) AS 'PPI'
FROM SMARTPHONES;
alter table smartphone rename smartphones ;
SELECT MODEL,'SMARTPHONES' AS 'TYPE' FROM SMARTPHONES;
SELECT DISTINCT(BRAND_NAME) AS 'BRAND' , COUNT(*) AS TOTAL_BRAND 
FROM SMARTPHONES
GROUP BY BRAND_NAME;
SELECT * FROM SMARTPHONES;
SELECT DISTINCT BRAND_NAME,PROCESSOR_BRAND FROM SMARTPHONES;

SELECT BRAND_NAME,COUNT(*)AS TOTAL_COUNT FROM SMARTPHONES
WHERE BRAND_NAME = 'SAMSUNG';

SELECT * FROM SMARTPHONES
WHERE PRICE>50000
ORDER BY PRICE ASC;

SELECT * FROM SMARTPHONES
WHERE PRICE>50000 AND RATING>80 AND PROCESSOR_BRAND = 'SNAPDRAGON';

SELECT model,num_rear_cameras + num_front_cameras as 'Total_cameras'
from smartphones
order by total_cameras desc;

select model,round(sqrt((RESOLUTION_WIDTH*RESOLUTION_WIDTH + RESOLUTION_HEIGHT*RESOLUTION_HEIGHT)/SCREEN_SIZE)) as 'PPI'
from smartphones
order by PPI;

select * from smartphones;

SELECT battery_capacity 
from smartphones
order by battery_capacity desc limit 1,1;

select battery_capacity from smartphones
order by battery_capacity asc;

SELECT battery_capacity 
from smartphones
order by battery_capacity asc limit 1,1;

select battery_capacity as max_battery_capacity from smartphones
order by battery_capacity desc;

select max(battery_capacity) as battery_capacity
from smartphones
where battery_capacity <(select max(battery_capacity) as battery_capacity from smartphones);

with rankedbattery as ( 
	select battery_capacity ,rank() over(order by battery_capacity desc)  as rnk
    from smartphones
)
select battery_capacity
from rankedbattery
where rnk = 2;

with rank_of_battery as (
	select battery_capacity, row_number() over (order by battery_capacity desc ) as rnk
    from smartphones
)
select battery_capacity
from rank_of_battery
where rnk = 2;

select* from smartphones;

select model,rating 
from smartphones
where brand_name = 'apple'
order by rating asc limit 1;

select rating from smartphones 
where brand_name ='apple'
order by rating asc;

select * from smartphones;

select model,rating
from smartphones
order by model asc,rating desc;

select model,price 
from smartphones
order by model asc,price desc;

select * from smartphones;
select brand_name,count(*) as total_count 
from smartphones
group by brand_name
order by total_count desc;

SELECT brand_name,count(*) as total_number,round(AVG(price),2) as average_price,max(rating) as 'highest rating',round(AVG(screen_size),2) as 'average screen size',round(AVG(battery_capacity),2) as 'average battery capacity'
FROM smartphones
GROUP BY brand_name;

SELECT * FROM smartphones;

SELECT has_nfc,avg(price) as 'average price',avg(rating) as 'average rating'
FROM smartphones
WHERE has_nfc = 'true'
GROUP BY has_nfc;

SELECT extended_memory_available,round(avg(price),2) as 'average price' 
FROM smartphones
WHERE extended_memory_available = 1
GROUP BY extended_memory_available;

SELECT brand_name,processor_brand,count(model) as 'model count',round(avg(primary_camera_rear),2) as 'average primary camera rear'
FROM smartphones
GROUP BY brand_name,processor_brand;

SELECT brand_name,price
FROM smartphones
order by price desc limit 5;

SELECT brand_name,min(screen_size) as 'Smallest_screen_size'
FROM smartphones
group by brand_name;

SELECT has_5g,avg(price) as 'average_price'
FROM smartphones
GROUP BY has_5g;

select * from smartphones;

select brand_name,count(model) as 'total model' 
from smartphones
where 
has_nfc = 'true' and
has_ir_blaster = 'true'
group by brand_name
order by brand_name desc limit 1;

select brand_name,has_nfc,avg(price) as 'average price'
from smartphones
where brand_name = 'samsung' and has_5g = 'true'
group by has_nfc,has_5g;

select * from smartphones;
select model,max(price) as 'costliest phone'
from smartphones
group by model 
order by model desc limit 1;

select brand_name,round(avg(rating),2) as 'average rating',count(model) as 'total_phones'
from smartphones
group by brand_name
having total_phones >20;
select * from smartphones;

select brand_name,avg(ram_capacity)as 'ram_capacity',refresh_rate,fast_charging_available,count(model) as 'total_phones'
from smartphones
where refresh_rate >=90 and fast_charging_available = 1
group by brand_name,refresh_rate,fast_charging_available
having total_phones >=10
order by total_phones desc limit 3;

select brand_name,count(model) as 'total_phones'
from smartphones
group by brand_name
having total_phones <10;

select brand_name,round(avg(rating),2) as 'average_rating',avg(price) as 'average_price' ,count(model)as 'total_phones'
from smartphones
where has_5g = 'true'
group by brand_name,has_5g
having avg(rating)>70 and total_phones >10;

#Find the top- three range of a model with price .

select brand_name,model,price,
case 
	when bucket = 1 then 'Budget'
    when bucket = 2 then 'Mid-Range'
    when bucket = 3 then 'Premium'
end  as 'phone_type'
from (select brand_name,model,price,
ntile(3) over(order by price ) as 'Bucket'
from smartphones)t





