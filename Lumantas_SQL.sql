-- create
CREATE TABLE FOOD_ITEM (
  itemId INTEGER PRIMARY KEY,
  name TEXT,
  category TEXT,
  calories INTEGER,
  price REAL
);

-- insert
INSERT INTO FOOD_ITEM VALUES (2001, 'Apple', 'Fruit', 95, 1.20);
INSERT INTO FOOD_ITEM VALUES (2002, 'Banana', 'Fruit', 105, 0.50);
INSERT INTO FOOD_ITEM VALUES (2003, 'Broccoli', 'Vegetable', 50, 1.50);
INSERT INTO FOOD_ITEM VALUES (2004, 'Chicken Breast', 'Meat', 165, 5.50);
INSERT INTO FOOD_ITEM VALUES (2005, 'Salmon', 'Seafood', 206, 8.75);
INSERT INTO FOOD_ITEM VALUES (2006, 'Almonds', 'Snack', 164, 3.20);
INSERT INTO FOOD_ITEM VALUES (2007, 'Yogurt', 'Dairy', 150, 1.10);
INSERT INTO FOOD_ITEM VALUES (2008, 'Cheddar Cheese', 'Dairy', 113, 2.75);
INSERT INTO FOOD_ITEM VALUES (2009, 'Carrot', 'Vegetable', 41, 0.80);
INSERT INTO FOOD_ITEM VALUES (2010, 'Beef Steak', 'Meat', 250, 12.00);
INSERT INTO FOOD_ITEM VALUES (2011, 'Walnuts', 'Snack', 185, 4.50);
INSERT INTO FOOD_ITEM VALUES (2012, 'Orange', 'Fruit', 62, 1.00);
INSERT INTO FOOD_ITEM VALUES (2013, 'Shrimp', 'Seafood', 99, 9.50);
INSERT INTO FOOD_ITEM VALUES (2014, 'Whole Milk', 'Dairy', 150, 2.20);
INSERT INTO FOOD_ITEM VALUES (2015, 'Potato', 'Vegetable', 161, 0.60);

-- create 2nd table FOOD_REVIEW
CREATE TABLE FOOD_REVIEW (
  reviewId INTEGER PRIMARY KEY,
  itemId INTEGER,
  reviewerName TEXT,
  rating INTEGER,
  reviewDate TEXT,
  FOREIGN KEY (itemId) REFERENCES FOOD_ITEM(itemId)
);

-- insert 15 reviews related to FOOD_ITEM
INSERT INTO FOOD_REVIEW VALUES (3001, 2001, 'Avery', 5, '2026-01-05');
INSERT INTO FOOD_REVIEW VALUES (3002, 2001, 'Liam', 4, '2026-01-07');
INSERT INTO FOOD_REVIEW VALUES (3003, 2002, 'Mila', 5, '2026-01-08');
INSERT INTO FOOD_REVIEW VALUES (3004, 2003, 'Nice', 4, '2026-01-10');
INSERT INTO FOOD_REVIEW VALUES (3005, 2004, 'Emma', 5, '2026-01-12');
INSERT INTO FOOD_REVIEW VALUES (3006, 2005, 'Oliver', 4, '2026-01-14');
INSERT INTO FOOD_REVIEW VALUES (3007, 2006, 'Sophie', 3, '2026-01-16');
INSERT INTO FOOD_REVIEW VALUES (3008, 2007, 'Elijem', 4, '2026-01-18');
INSERT INTO FOOD_REVIEW VALUES (3009, 2008, 'Isabel', 5, '2026-01-20');
INSERT INTO FOOD_REVIEW VALUES (3010, 2009, 'James', 4, '2026-01-22');
INSERT INTO FOOD_REVIEW VALUES (3011, 2010, 'Charles', 5, '2026-01-24');
INSERT INTO FOOD_REVIEW VALUES (3012, 2011, 'Benjie', 3, '2026-01-26');
INSERT INTO FOOD_REVIEW VALUES (3013, 2012, 'Amy', 5, '2026-01-28');
INSERT INTO FOOD_REVIEW VALUES (3014, 2013, 'Luke', 4, '2026-01-30');
INSERT INTO FOOD_REVIEW VALUES (3015, 2015, 'Harry', 4, '2026-02-01');

-- fetch
-- Insight: What is the average price and average calorie count for each food category, 
-- ordered from the most expensive category to the least?

SELECT category, AVG(calories) AS avg_calories, AVG(price) AS avg_price
FROM FOOD_ITEM 
GROUP BY category 
ORDER BY avg_price DESC;

-- Insight: What is the overall distribution of ratings? (How many 5-star, 4-star, and 3-star reviews have been left in total?)
SELECT rating, COUNT(reviewId) AS total_reviews
FROM FOOD_REVIEW
GROUP BY rating
ORDER BY rating DESC;

-- Insight: Which food items have reviews, and what are their average ratings?
SELECT f.itemId, f.name, f.category, f.price,
       AVG(r.rating) AS average_rating,
       COUNT(r.reviewId) AS review_count
FROM FOOD_ITEM AS f
JOIN FOOD_REVIEW AS r ON f.itemId = r.itemId
GROUP BY f.itemId, f.name, f.category, f.price
ORDER BY average_rating DESC, review_count DESC;

-- Insight: Which reviewers gave ratings of 5, and which food items did they review?
SELECT r.reviewerName, f.name, f.category, r.rating, r.reviewDate
FROM FOOD_REVIEW AS r
JOIN FOOD_ITEM AS f ON r.itemId = f.itemId
WHERE r.rating = 5
ORDER BY r.reviewDate;

-- Insight: Which food categories have the highest average customer ratings, and how many total reviews does each category have?
SELECT f.category, 
       AVG(r.rating) AS avg_category_rating, 
       COUNT(r.reviewId) AS total_reviews
FROM FOOD_ITEM AS f
JOIN FOOD_REVIEW AS r ON f.itemId = r.itemId
GROUP BY f.category
ORDER BY avg_category_rating DESC, total_reviews DESC;
