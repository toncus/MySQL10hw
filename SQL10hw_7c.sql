SELECT first_name, last_name, email, country FROM customer
LEFT JOIN address
ON customer.address_id = address.address_id
LEFT JOIN city
ON city.city_id = address.city_id
LEFT JOIN country
ON country.country_id = city.country_id
WHERE country = "Canada";