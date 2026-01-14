# FLIPKART_ECOMMERCE
# Flipkart E-commerce Data Analysis (MySQL)

## Project Overview

This project focuses on analyzing Flipkart e-commerce data using **MySQL** to derive business insights related to **products, brands, pricing, discounts, and customer ratings**. The analysis simulates real-world scenarios faced by e-commerce companies and demonstrates strong SQL querying, data cleaning, and analytical skills.

This project is suitable for **Data Analyst interviews (Deloitte, Accenture, Infosys, Amazon, etc.)** and showcases practical use of SQL for decision-making.

---

##  Tools & Technologies

* **Database:** MySQL
* **Language:** SQL
* **Concepts Used:**

  * Joins & Subqueries
  * Window Functions (`DENSE_RANK`, `OVER`, `PARTITION BY`)
  * Aggregate Functions (`COUNT`, `AVG`, `SUM`)
  * Data Cleaning & Transformation
  * Business-oriented analytical queries

---

## Dataset Description

The dataset contains Flipkart e-commerce product information, including:

* Product Name
* Brand
* Retail Price
* Discounted Price
* Product Rating
* Overall Rating
* Product Category Tree
* Crawl Timestamp

---

## ⚙️ Database Setup

```sql
CREATE DATABASE FLIPKART;
USE FLIPKART;

RENAME TABLE `flipkart_com-ecommerce_sample` TO flipkart_commerce;
```

---

## 🧹 Data Cleaning Steps

* Converted price columns to appropriate numeric data types.
* Handled invalid rating values such as **'No rating available'** by converting them to `NULL`.
* Ensured safe update settings before performing updates.

```sql
SET SQL_SAFE_UPDATES = 0;

UPDATE flipkart_commerce
SET product_rating = NULL
WHERE product_rating = 'No rating available';
```

---

## 📊 Key Analysis & Queries

### 1. Product & Brand Analysis

* Count of unique products available on Flipkart
* Number of distinct brands selling products
* Ranking brands based on number of products

### 2. Pricing & Discount Analysis

* Products with highest discount amounts
* Brands offering the highest average discount
* Products priced higher than their brand average

### 3. Time-Series Analysis

* Monthly sales trend using crawl timestamp
* Identifying periods of sales drop

### 4. Rating-Based Insights

* Products with high discount but low ratings
* Brands with average ratings above overall average
* Identifying underperforming products

### 5. Advanced SQL (Window Functions)

* Ranking products within each brand based on discount
* Ranking brands using `DENSE_RANK`

---

##  Business Use Cases

* Identify **underperforming products** for removal
* Detect brands with **many products but poor ratings**
* Help management decide which brands or categories to promote
* Improve customer satisfaction by analyzing price vs rating

---

##  Key Insights

* High discounts do not always guarantee high ratings
* Some brands dominate the platform by product volume but lack quality
* Certain categories consistently offer higher discounts
* Pricing strategy directly impacts customer perception

---

##  Learning Outcomes

* Strong understanding of **SQL analytics**
* Hands-on experience with **real-world e-commerce data**
* Ability to translate business questions into SQL queries
* Improved problem-solving and analytical thinking

---

##  Future Enhancements

* Integrate the data with **Power BI / Tableau dashboards**
* Perform **category-wise profitability analysis**
* Add **customer review sentiment analysis**
* Optimize queries for large-scale datasets

---


---

## 👤 Author

**Lavnya**
Aspiring Data Analyst | SQL | Power BI | Excel

---

⭐ *This project demonstrates practical SQL skills aligned with industry-level data analyst requirements.*
