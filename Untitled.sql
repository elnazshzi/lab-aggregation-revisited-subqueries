-- 1.Select the first name, last name, and email address of all the customers who have rented a movie.

select c.first_name, last_name,email
from sakila.customer c
join sakila.rental  r using(customer_id);       



-- 2.What is the average payment made by each customer 
-- (display the customer id, customer name (concatenated), and the average payment made).

select c.customer_id,
       concat(c.first_name,'',c.last_name) customer_name,
       avg(p.amount) avg_payment
from sakila.customer c 
join sakila.payment p using(customer_id)
group by c.customer_id,customer_name;




-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
-- A) Write the query using multiple join statements

SELECT  
    c.first_name,
    c.last_name,
    c.email,
    ct.name as rented_category
FROM 
    sakila.customer c
JOIN sakila.rental r ON c.customer_id = r.customer_id
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON i.film_id = f.film_id
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category ct ON fc.category_id = ct.category_id
WHERE 
    ct.name = 'Action';



-- B) Write the query using sub queries with multiple WHERE clause and IN condition

select 
      c.first_name,
      c.last_name,
      c.email
from sakila.customer c 
where customer_id in (
                      select customer_id
                      from sakila.customer c
                      join sakila.rental r using(customer_id)
                      join sakila.inventory i using(inventory_id)
                      join sakila.film f using(film_id)
                      where f.film_id in ( 
                                           select film_id
                                           from sakila.film f 
                                           join sakila.film_category fc using(film_id)
                                           join sakila.category ct using (category_id)
                                           where ct.name = 'Action')
                                           )
;



-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment.
--  If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
-- and if it is more than 4, then it should be high.

select *, case 
              when p.amount between 0 and 2 then  'low'
              when p.amount between 2 and 4 then  'medium'
              when p.amount > 4 then 'high'
		 end as amount_level
 from sakila.payment p;



















