-- Verify connection to DB using the Actor Table
SELECT *
FROM actor;


-- SELECT first_name and last_name
-- FROM actor TABLE
SELECT first_name, last_name
FROM actor;


-- Query first_name which equals 'Nick'
-- Using the WHERE Clause
SELECT first_name, last_name
FROM actor
WHERE first_name = 'Nick';


-- Query first_name which equals 'Nick'
-- Using LIKE clause
-- NOTE: ( = ) is looking for a literal string
-- while the LIKE Clause allows use for wildcards
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'Nick';

-- Using LIKE Clause and WILD CARD ( % )
-- Get all J names
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'J%';

-- Single Character Wild Card ( _ )
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'K__';

-- Query for all first_names that start with 'K__%' has two letters, anything goes after
SELECT first_name, last_name
FROM actor
WHERE first_name LIKE 'K__%';

----- Comparasion Operators:
-- = Equals to
-- > Greater Than
-- < Less Than
-- >= Greater Than or Equal to
-- <= Less Than or Equal to
-- <> Not equals

-- Using Comparasion Operators with the Payment Table
SELECT *
FROM payment;

-- Query WHERE amount GREATER THAN $10.
SELECT amount
FROM payment
WHERE amount >10;

-- Query amounts BETWEEN $10-$15
-- NOTE: When using BETWEEN both values are inclusive
SELECT amount
FROM payment
WHERE amount between 10 AND 15;

-- Order the payments by amount
-- Using the ORDER BY
-- ASC for ascending order (Default)
-- DESC for decending order
SELECT amount
FROM payment
ORDER BY  amount DESC;

-- Query all payments NOT EQUAL to 2.99
SELECT amount
FROM payment
WHERE amount <> 2.99;

----- Aggregate Functions
-- MIN()
-- MAX()
-- SUM()
-- AVG()
-- COUNT()

-- Query the SUM of amounts GREATER THAN OR EQUAL TO 5.99
SELECT SUM(amount)
FROM payment
WHERE amount >= 5.99;

-- Query the AVG of amounts GREATER THAN OR EQUAL TO 5.99
SELECT AVG(amount)
FROM payment
WHERE amount >= 5.99;

-- Query the COUNT of amounts GREATER THAN OR EQUAL TO 5.99
SELECT COUNT(amount)
FROM payment
WHERE amount >= 5.99;

-- Query to display the COUNT of DISTINCT amounts paid
SELECT COUNT(DISTINCT amount)
FROM payment;

-- Query to display the MIN paid using alias
SELECT MIN(amount) AS min_amount_paid
FROM payment;

-- Query to display the MAX paid using alias
SELECT MAX(amount) AS min_amount_paid
FROM payment;

-- GROUP BY (Used with aggregate functions)
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id;

-- Query the customer that paid the most
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- HAVING Works with aggregates, WHERE does not.
SELECT customer_id, SUM(amount)
FROM payment
WHERE amount> 10
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT amount
FROM payment
ORDER BY amount DESC
LIMIT 10;





-- 1. How many actors are there with the last name ‘Wahlberg’?
-- There are 2 actors with the last name Wahlberg in the actor file.
SELECT first_name, last_name
FROM actor
WHERE last_name = 'Wahlberg';

-- 2. How many payments were made between $3.99 and $5.99?
-- There are zero payments made between 3.99 and 5.99.
SELECT amount
FROM payment
WHERE amount BETWEEN 3.99 AND 5.99;

-- 3. What film does the store have the most of? (search in inventory)
-- Zorro Ark is the film the store has the most of.
--First I found which movie appeared the most in inventory, then I pulled up that film_id in film and got the name.
SELECT MAX(film_id)
FROM inventory;

SELECT film_id, title
FROM film
WHERE film_id = 1000;


-- 4. How many customers have the last name ‘William’?
-- There are 0 customer with the last name William
SELECT first_name, last_name
FROM customer
WHERE last_name = 'William';

-- 5. What store employee (get the id) sold the most rentals?
-- John Stephens sold the most rentals.  I grouped up all payments and grouped up the staff_id to combine duplicates.  Then I pulled up the name of the employee using their number from the staff list.
SELECT COUNT(payment_id), staff_id
FROM payment
GROUP BY staff_id
ORDER BY COUNT(payment_id) DESC;

SELECT staff_id, first_name, last_name
FROM staff
WHERE staff_id = 2;

-- 6. How many different district names are there?
--There are 378 district names.  I displayed all of the district names then grouped them so there would be no duplicates.
SELECT COUNT(DISTINCT district)
FROM address;


-- 7. What film has the most actors in it? (use film_actor table and get film_id)
--Lambs Cincinatti has the most actors in it.  I grouped up the film and actor id's to show which film had the most actors then i used the film id to get the title name.
SELECT film_id, COUNT(actor_id)
FROM film_actor
GROUP BY film_id
ORDER BY COUNT(actor_id) DESC;

SELECT film_id, title
FROM film
WHERE film_id = 508;

-- 8. From store_id 1, how many customers have a last name ending with ‘es’? (use customer table)
--There are 13 customer ending with last names ending in -es in store_id 1.
SELECT store_id, first_name, last_name
FROM customer
WHERE last_name LIKE '%es' AND store_id = 1;

-- 9. How many payment amounts (4.99, 5.99, etc.) had a number of rentals above 250 for customers
-- with ids between 380 and 430? (use group by and having > 250)
-- The answer is 3 with 281 instances of -415.01

--OG CODE--
-- SELECT customer_id, COUNT(amount), rental_id
-- FROM payment
-- WHERE customer_id BETWEEN 380 AND 430 AND rental_id > 250
-- GROUP BY customer_id AND rental_id
-- ORDER BY COUNT(amount) DESC;

--CODE WITH DYLAN HELP--
SELECT COUNT(amount), amount
FROM payment
WHERE customer_id BETWEEN 380 AND 430
GROUP BY amount
HAVING COUNT(amount) > 250;

-- 10. Within the film table, how many rating categories are there? And what rating has the most
-- movies total?
--There are 5 movie ratings and PG-13 has the most films
SELECT rating, COUNT(film_id)
FROM film
GROUP BY rating
ORDER BY COUNT(film_id) DESC;