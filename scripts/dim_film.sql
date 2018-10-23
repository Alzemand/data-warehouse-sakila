SELECT 
film_id, 
title, 
description, 
cast(release_year as char(4)) release_year,
rental_duration,
rental_rate,
length,
replacement_cost,
rating,
special_features,
l.name language
FROM sakila.film f
left join sakila.language l
on f.language_id = l.language_id