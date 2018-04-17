select store.store_id, concat('$',format(sum(amount),2)) as total_business
from store
join customer
using (store_id)
join payment
on (customer.customer_id = payment.customer_id)
group by (store.store_id); 