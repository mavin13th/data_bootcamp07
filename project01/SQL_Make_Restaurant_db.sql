.open restaurant.db

--Drop table
  drop table menus;
  drop table customers;
  drop table countrys;
  drop table invoices;
  drop table ingredients;

--Table 1 = menus
create table menus(
  menu_id int,
  menu_name text,
  customer_name text,
  menu_price real
);
insert into menus values
  (1, "Cabonara Spaghetti", "Jame", 200),
  (2, "Spicy Spaghetti", "Guy", 150),
  (3, "Pad Thai", "John", 80),
  (4, "Tom yum", "Jame", 80),
  (5, "Fried rice", "Chole", 50);

--Table 2 = customers
create table customers(
  customer_id int,
  customer_name text,
  customer_genre text,
  customer_age real
);
  insert into customers values
  (1, "Jame","Male", 25),
  (2, "Chole", "Female", 30),
  (3, "Guy", null, 28),
  (4, "May", "Female", 15),
  (5, "John", "Male", 40);

--Table 3 = countrys
create table countrys(
  country_id int,
  country_name text,
  country_city text,
  menu_name text
);
  insert into countrys values
  (101, "Argentina", "Buenos Aires", "Fried rice"),
  (102, "England", "Manchester", "Cabonara Spaghetti"),
  (103, "Thailand", "Bangkok", "Tom yum"),
  (104, "Vietnam", "Da nang", "Pad Thai"),
  (105, "Japan", "Osaka", "Spicy Spaghetti"),
  (106, "Italy", "Rome", "Cabonara Spaghetti");

--Table 4 = invoices
create table invoices(
  invoice_id int,
  invoice_date text,
  customer_id int,
  invoice_price real
);
insert into invoices values
  (1, "2022-05-19", 1, 280),
  (2, "2022-07-11", 3, 160),
  (3, "2022-11-08", 5, 100),
  (4, "2022-05-21", 1, 550);

-- Table 5 ingredients
create table ingredients(
  menu_id int,
  ingredient_name text,
  ingredient_type text,
  ingredient_qty real
);
insert into ingredients values
  (1, "Garlic", "Vegetable", 2),
  (2, "Cheese", "Vegetable", 1),
  (4, "Bacon", "Meat", 5),
  (4, "Pepper", "Vegetable", 1),
  (5, "Shell", "Seafood", 8),
  (3, "Shrimp", "Seafood", 4),
  (5, "Tofu", "Vegetable", 3),
  (2, "Garlic", "Vegetable", 2),
  (4, "Shrimp", "Seafood", 5),
  (1, "Mushroom", "Vegetable", 6),
  (1, "Squid", "Seafood", 2),
  (2, "Pork", "Meat", 2);

.mode column
.header on

--5query (Join,where,group by, order by, strftime)
--Example1 (join, where)
select 
  *
  from menus as m
join customers as c on m.customer_name = c.customer_name
Left join invoices as i on i.customer_id = c.customer_id
where c.customer_id between 1 AND 5;
--Example2 (join, where, group by)
select 
  menu_price
  from menus as m
join customers as c on m.customer_name = c.customer_name
Left join invoices as i on i.customer_id = c.customer_id
where c.customer_id between 1 AND 5
group by menu_price
order by customer_age;
--Example3 (join, where, order by)
select 
  menu_name, invoice_date, customer_age
  from menus as m
join customers as c on m.customer_name = c.customer_name
Left join invoices as i on i.customer_id = c.customer_id
where c.customer_id between 1 AND 5
order by customer_age desc;
--Example 4 (Strftime)
select
  strftime('%Y',invoice_date) as year,
  strftime('%m',invoice_date) as month,
  strftime('%d',invoice_date) as day,
  strftime('%Y%m',invoice_date) as year_month 
from invoices;

--with query
with a as(
  select * from customers
  where customer_name = 'Jame'
), b as(
  select * from invoices
  where STRFTIME("%Y", invoice_date) = "2022"
)
select a.customer_name, sum(b.invoice_price)
from a
join b on a.customer_id = b.customer_id
group by 1;

--sub query
select * from(
  select country_name, country_city
  from countrys)
where country_name = 'Italy';

--aggregate function
select
count(*) as no_in,
AVG (ingredient_qty) as avg_in,
SUM (ingredient_qty) as sum_in,
MIN (ingredient_qty) as min_in,
MAX (ingredient_qty) as max_in
from menus as m
join ingredients as ing on m.menu_id = ing.menu_id;
