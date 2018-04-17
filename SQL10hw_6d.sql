SELECT film.title, COUNT(inventory_id) AS 'Number of Copies'
FROM inventory INNER JOIN film ON inventory.film_id 
WHERE film.title = 'Hunchback Impossible'
GROUP BY film.film_id


