## Lab | SQL Queries 8

## In this lab, you will be using the Sakila database of movie rentals.

use sakila; ## Use the database sakila 

## Instructions
## Rank films by length (filter out the rows with nulls or zeros in length column). Select only columns title, length and rank in your output.

select title, length  
	from film
		where length is not null AND length >0  ## filtering out the rows with nulls or zeros in length column
			order by length DESC;
                      
## Rank films by length within the rating category (filter out the rows with nulls or zeros in length column). In your output, only select the columns title, length, rating and rank.

select * from film;

select title, length, rating, rank ()over(order by length DESC) as ranking
	from film
		where length is not null AND length >0  ## filtering out the rows with nulls or zeros in length column
			order by length DESC;

## How many films are there for each of the categories in the category table? Hint: Use appropriate join between the tables "category" and "film_category".

select * from category;  ## There are 16 different category_id. Table category has the columns --- category_id, name, last_update
select * from film_category;  ## Table film_category has the columns --- film_id, category_id, last_date

	## As I am using the tables "category" and "film_category", I could consider the column "category_id" as the PRIMARY KEY
	## c = table "category"
    ## fc = table "film_category"

select c.name as category, count(fc.film_id) as number_films
	from category c
		join film_category fc
		on c.category_id = fc.category_id
			group by c.category_id, c.name
				order by number_films desc;
            
## Which actor has appeared in the most films? Hint: You can create a join between the tables "actor" and "film actor" and count the number of times an actor appears.

select * from actor;
select * from film_actor;

select a.first_name, a.last_name, count(fa.film_id) as number_films
	from actor a
		join film_actor fa
		on a.actor_id = fa.actor_id
			group by a.actor_id
				order by number_films desc;  ## ranking all the actors according to the ones appeared in most films
                
  select a.first_name, a.last_name, count(fa.film_id) as number_films
	from actor a
		join film_actor fa
		on a.actor_id = fa.actor_id
			group by a.actor_id
				order by number_films desc
					limit 1;  ## ranking the top 1 actor who appeared in most films

## Which is the most active customer (the customer that has rented the most number of films)? Hint: Use appropriate join between the tables "customer" and "rental" and count the rental_id for each customer.

select * from customer; ## columns --- customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
select * from rental; ## columns --- rental_id, rental_date, inventory_id, customer_id, return_date, staff_id, last_update

  select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as number_rentals
	from customer c
		join rental r
		on c.customer_id = r.customer_id
			group by c.customer_id
				order by number_rentals desc;  ## ranking the most active customers
	

  select c.customer_id, c.first_name, c.last_name, count(r.rental_id) as number_rentals
	from customer c
		join rental r
		on c.customer_id = r.customer_id
			group by c.customer_id
				order by number_rentals desc  
					limit 1;  ## Eleanor Hunt is the msot active customer