# MySQL10hw
**********************Homework Assignment*************************

MySQL random homework questions on sakila database
Homework Assignment


1a. Display the first and last names of all actors from the table actor.

Answer: select first_name, last_name from sakila.actor;

1b. Display the first and last name of each actor in a single column in upper case letters. Name the column Actor Name.
Answer: select UPPER(CONCAT(first_name,' ', last_name)) AS 'Actor Name' from sakila.actor;

2a. You need to find the ID number, first name, and last name of an actor, of whom you know only the first name, "Joe." What is one query would you use to obtain this information?
Answer: select actor_id, first_name, last_name from sakila.actor WHERE first_name LIKE 'Joe%';

2b. Find all actors whose last name contain the letters GEN:
Answer: select first_name, last_name from sakila.actor WHERE last_name LIKE '%GEN%';

2c. Find all actors whose last names contain the letters LI. This time, order the rows by last name and first name, in that order:
Answer: 
select first_name, last_name from sakila.actor 
WHERE last_name LIKE '%LI%'
order by last_name, first_name
;

2d. Using IN, display the country_id and country columns of the following countries: Afghanistan, Bangladesh, and China:
Answer:
select country_id, country from sakila.country
 WHERE country IN ('Afghanistan', 'Bangladesh', 'China')
;

3a. Add a middle_name column to the table actor. Position it between first_name and last_name. Hint: you will need to specify the data type.
Answer: ALTER TABLE sakila.actor ADD middle_name VARCHAR(45) AFTER `first_name`;

3b. You realize that some of these actors have tremendously long last names. Change the data type of the middle_name column to blobs.
Answer:  ALTER TABLE sakila.actor  MODIFY COLUMN `middle_name` blob;

3c. Now delete the middle_name column.
Answer:  ALTER TABLE sakila.actor DROP COLUMN middle_name;  

4a. List the last names of actors, as well as how many actors have that last name.
Answer:  select last_name, count(*) from sakila.actor group by last_name;

4b. List last names of actors and the number of actors who have that last name, but only for names that are shared by at least two actors
Answer:
select last_name, count(*) from sakila.actor
group by last_name
having count(last_name) > 2;

4c. Oh, no! The actor HARPO WILLIAMS was accidentally entered in the actor table as GROUCHO WILLIAMS, the name of Harpo's second cousin's husband's yoga teacher. Write a query to fix the record.
Answer:  UPDATE sakila.actor SET first_name='HARPO' WHERE first_name='GROUCHO' && last_name='WILLIAMS';

4d. Perhaps we were too hasty in changing GROUCHO to HARPO. It turns out that GROUCHO was the correct name after all! In a single query, if the first name of the actor is currently HARPO, change it to GROUCHO. Otherwise, change the first name to MUCHO GROUCHO, as that is exactly what the actor will be with the grievous error. BE CAREFUL NOT TO CHANGE THE FIRST NAME OF EVERY ACTOR TO MUCHO GROUCHO, HOWEVER! (Hint: update the record using a unique identifier.)
Answer:  UPDATE sakila.actor SET  first_name = CASE WHEN first_name = 'HARPO' THEN 'GROUCHO' ELSE 'MUCHO GROUCHO' END WHERE actor_id = 172;

5a. You cannot locate the schema of the address table. Which query would you use to re-create it? Hint: https://dev.mysql.com/doc/refman/5.7/en/show-create-table.html
Answer:  Show CREATE TABLE sakila.address;

6a. Use JOIN to display the first and last names, as well as the address, of each staff member. Use the tables staff and address:
Answer: select first_name, last_name, address from sakila.address JOIN sakila.staff on address.address_id=staff.address_id;

6b. Use JOIN to display the total amount rung up by each staff member in August of 2005. Use tables staff and payment.
Answer: 
select first_name, last_name, SUM(amount) from sakila.staff 
JOIN sakila.payment on staff.staff_id = payment.staff_id 
where YEAR(payment.payment_date)='2005' and month(payment.payment_date)='08'
group by last_name, first_name;

6c. List each film and the number of actors who are listed for that film. Use tables film_actor and film. Use inner join.
Answer: 
SELECT title, COUNT(actor_id) AS 'Number of Actors'
FROM film INNER JOIN film_actor 
ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY film.title

6d. How many copies of the film Hunchback Impossible exist in the inventory system?
Answer: 
SELECT film.title, COUNT(inventory_id) AS 'Number of Copies'
FROM inventory INNER JOIN film ON inventory.film_id 
WHERE film.title = 'Hunchback Impossible'
GROUP BY film.film_id

6e. Using the tables payment and customer and the JOIN command, list the total paid by each customer. List the customers alphabetically by last name:
Answer:
SELECT last_name, first_name, SUM(amount) as 'Total Paid'
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY last_name, first_name;

7a. The music of Queen and Kris Kristofferson have seen an unlikely resurgence. As an unintended consequence, films starting with the letters K and Q have also soared in popularity. Use subqueries to display the titles of movies starting with the letters K and Q whose language is English.
Answer:
SELECT title 
FROM film
WHERE language_id IN
	(
	SELECT language_id 
	FROM language
	WHERE name = 'English'
    )
	AND (title LIKE "K%") OR (title LIKE "Q%");

7b. Use subqueries to display all actors who appear in the film Alone Trip.
Answer:
SELECT first_name, last_name 
FROM actor 
WHERE actor_id IN
	(
	SELECT actor_id 
	FROM film_actor
	WHERE film_id IN
		(
		SELECT film_id
		FROM film
		WHERE title = 'Alone Trip'
		)
	);

7c. You want to run an email marketing campaign in Canada, for which you will need the names and email addresses of all Canadian customers. Use joins to retrieve this information.
Answer:
SELECT first_name, last_name, email, country FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN city
ON city.city_id = address.city_id
LEFT JOIN country
ON country.country_id = city.country_id
WHERE country = "Canada";


7d. Sales have been lagging among young families, and you wish to target all family movies for a promotion. Identify all movies categorized as famiy films.
Answer:
SELECT * FROM film
WHERE film_id IN
	(
	SELECT film_id 
	FROM film_category
	WHERE category_id IN
		(
		SELECT category_id
		FROM category
		WHERE name = "Family"
		)
	);

7e. Display the most frequently rented movies in descending order.
Answer:
SELECT inventory.film_id, film_text.title, COUNT(rental.inventory_id)
FROM inventory
INNER JOIN rental
ON inventory.inventory_id = rental.inventory_id
INNER JOIN film_text
ON inventory.film_id = film_text.film_id
GROUP BY rental.inventory_id
ORDER BY COUNT(rental.inventory_id) DESC;

7f. Write a query to display how much business, in dollars, each store brought in.
Answer:
select store.store_id, concat('$',format(sum(amount),2)) as total_business
from store
join customer
using (store_id)
join payment
on (customer.customer_id = payment.customer_id)
group by (store.store_id); 

7g. Write a query to display for each store its store ID, city, and country.
Answer:
SELECT store.store_id, city.city, country.country
FROM store
LEFT JOIN address
ON store.address_id = address.address_id
JOIN city 
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;

7h. List the top five genres in gross revenue in descending order. (Hint: you may need to use the following tables: category, film_category, inventory, payment, and rental.)
Answer:
SELECT category.name, sum(payment.amount) as 'Top Five Genres By Gross Revenue' 
FROM category
JOIN film_category 
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

8a. In your new role as an executive, you would like to have an easy way of viewing the Top five genres by gross revenue. Use the solution from the problem above to create a view. If you haven't solved 7h, you can substitute another query to create a view.
Answer:
CREATE VIEW top_five_genres_by_rev
AS SELECT category.name, sum(payment.amount) as 'Top Five Genres By Gross Revenue' 
FROM category
JOIN film_category 
ON category.category_id = film_category.category_id
JOIN inventory
ON film_category.film_id = inventory.film_id
JOIN rental
ON rental.inventory_id = inventory.inventory_id
JOIN payment
ON payment.rental_id = rental.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

8b. How would you display the view that you created in 8a?
Answer:  SELECT * FROM top_five_genres_by_rev;

8c. You find that you no longer need the view top_five_genres. Write a query to delete it.
Answer:  DROP VIEW top_five_genres_by_rev;
