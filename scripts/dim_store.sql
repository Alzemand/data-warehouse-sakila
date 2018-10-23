SELECT s.*, a.*, city, country
FROM sakila.store s
left join sakila.staff e on s.manager_staff_id=e.staff_id
left join sakila.address a on s.address_id=a.address_id
left join sakila.city city on city.city_id=a.city_id
left join sakila.country country on country.country_id=city.country_id