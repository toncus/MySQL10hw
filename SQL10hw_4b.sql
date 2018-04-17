select last_name, count(*) from sakila.actor
group by last_name
having count(last_name) > 2;
