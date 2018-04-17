SELECT title 
FROM film
WHERE language_id IN
	(
	SELECT language_id 
	FROM language
	WHERE name = 'English'
    )
	AND (title LIKE "K%") OR (title LIKE "Q%");