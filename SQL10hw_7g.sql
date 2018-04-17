SELECT store.store_id, city.city, country.country
FROM store
LEFT JOIN address
ON store.address_id = address.address_id
JOIN city 
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id;

