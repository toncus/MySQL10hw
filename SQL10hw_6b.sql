select first_name, last_name, SUM(amount) from sakila.staff 
JOIN sakila.payment on staff.staff_id = payment.staff_id
 
where YEAR(payment.payment_date)='2005' and month(payment.payment_date)='08'

group by last_name, first_name;





