SELECT title, COUNT(actor_id) AS 'Number of Actors'
FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id
GROUP BY film.film_id
ORDER BY film.title
