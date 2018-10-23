SELECT * 
FROM sakila.customer c
left join sakila.address a
on c.address_id = a.address_id