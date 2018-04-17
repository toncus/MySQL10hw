SELECT last_name, first_name, SUM(amount) as 'Total Paid'
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
GROUP BY payment.customer_id
ORDER BY last_name, first_name;