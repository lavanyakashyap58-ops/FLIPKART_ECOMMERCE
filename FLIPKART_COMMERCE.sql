CREATE DATABASE FLIPKART;
use FLIPKART;
rename table `flipkart_com-ecommerce_sample` to flipkart_commerce;



alter TABLE  flipkart_commerce
MODIFY column Org_price
DECIMAL(10,0);

SELECT * FROM flipkart_commerce ;

alter table  flipkart_commerce
drop column Org_price;

-- How many unique products are available on the Flipkart platform?
SELECT distinct product_name from  flipkart_commerce;

-- How many distinct brands are selling products?
select distinct brand from flipkart_commerce;

-- Identify Time Period of Drop
SELECT 
    DATE_FORMAT(crawl_timestamp, '%Y-%m') AS month,
    SUM(retail_price) AS total_revenue
FROM flipkart_commerce
GROUP BY month
ORDER BY month;

-- Category-Level Impact
SELECT 
    product_category_tree,
    AVG(retail_price - discounted_price) AS avg_discount
FROM flipkart_commerce
GROUP BY product_category_tree
ORDER BY avg_discount DESC;

-- Product-Level Analysis
SELECT 
    product_name,
    retail_price,
    discounted_price,
    overall_rating,
    product_rating
FROM
    flipkart_commerce
ORDER BY (retail_price - discounted_price) DESC
LIMIT 10;

-- Brand Impact
select brand, 
	   product_count, 
dense_rank() over (order by product_count desc ) as Brand_rank  
from ( select  
      brand, 
      count(product_name) as product_count
      from flipkart_commerce
     group by brand
 )p
 limit 20 ;


-- Which brands offer the highest average discount amount?
select brand , avg(discounted_price) from flipkart_commerce
group by brand 
order by avg(discounted_price) desc limit 1;

-- Which products have retail price higher than the brand average price?

SELECT 
    product_name,
    brand,
    retail_price
FROM flipkart_commerce f
WHERE retail_price > (
    SELECT AVG(retail_price)
    FROM flipkart_commerce
    WHERE brand = f.brand
);


-- Find brands whose average product rating is above the overall average rating.
SELECT DISTINCT
    brand
FROM
    flipkart_commerce t
WHERE
    product_rating < (SELECT 
            AVG(product_rating)
        FROM
            flipkart_commerce
        WHERE
            brand = t.brand);
		
-- Filtering 
UPDATE flipkart_commerce
SET product_rating = null
WHERE product_rating = 'No rating available' ;

SET SQL_SAFE_UPDATES = 0;

-- Identify products that have high discount but low rating.
SELECT 
    product_name,
    retail_price,
    discounted_price,
    product_rating,
    (retail_price - discounted_price) AS discount_amount
FROM flipkart_commerce
WHERE (retail_price - discounted_price) > (
        SELECT AVG(retail_price - discounted_price)
        FROM flipkart_commerce
      )
  AND product_rating < (
        SELECT AVG(product_rating)
        FROM flipkart_commerce
        WHERE product_rating IS NOT NULL
      );

-- Rank brands based on number of products (use DENSE_RANK).
SELECT brand ,
       NO_PRODUCT ,
       dense_rank() OVER(order by NO_PRODUCT desc) as product_rank from
(select   brand,
         count(product_name)as NO_PRODUCT from flipkart_commerce
       GROUP BY brand )t
limit 20;

-- Rank products within each brand based on discount amount.
SELECT brand ,
	   product_name,
	   discount_amount,
       dense_rank() OVER(partition by brand order by discount_amount desc) as product_rank from
(select  brand,
		 product_name,
		(retail_price - discounted_price) AS discount_amount from flipkart_commerce
       )t ;
       
       
-- Management wants to remove underperforming products.
-- How would you identify products with low rating and low discount?


SELECT 
    product_name,
    brand,
    product_rating,
    (retail_price - discounted_price) AS discount_amount
FROM flipkart_commerce
WHERE product_rating < (
        SELECT AVG(product_rating)
        FROM flipkart_commerce
        WHERE product_rating IS NOT NULL
      )
  AND (retail_price - discounted_price) < (
        SELECT AVG(retail_price - discounted_price)
        FROM flipkart_commerce
      );

-- Identify brands that have many products but poor average ratings.
select brand , count_product,avg_product from
 (select brand , 
       count(product_name) as count_product ,
       avg(count(product_name)) over () as avg_count_product ,
       avg(product_rating) as avg_product ,
       avg(avg(product_rating)) over() as overall_product from flipkart_commerce
       where product_rating is not null
       group by brand)t
where count_product > avg_count_product  and 
avg_product > overall_product ;

select uniq_id ,retail_price ,discounted_price, (retail_price - discounted_price) as ogl_price from flipkart_commerce ;

