DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS line_items;

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  shipping_address TEXT,
  user_id INTEGER REFERENCES users (id)
);

CREATE TABLE IF NOT EXISTS products (
  id SERIAL PRIMARY KEY,
  name TEXT,
  price DECIMAL CHECK (price > 0)
);

CREATE TABLE IF NOT EXISTS line_items (
  id SERIAL PRIMARY KEY, 
  order_id INTEGER,
  product_id INTEGER,
  qty INTEGER
);
 
INSERT INTO users
  (name, email)
VALUES
  ('Daniel', 'gmail@daniel.com'),
  ('Tyler', 'gmail@t$.com'),
  ('Daniel', 'gmail@danny.luv');
    
INSERT INTO orders
  (shipping_address, user_id)
VALUES
  ('123 N Street Rd', 1),
  ('321 S Road St', 1),
  ('321 S Road St', 2),
  ('123 S Street Rd', 3);
    
INSERT INTO products
  (name, price)
VALUES
  ('AA Batteries', 5),
  ('AAA Batteries', 4),
  ('C Batteries', 6),
  ('D Batteries', 7),
  ('Z Batteries', 40);

INSERT INTO line_items
  (order_id, product_id, qty)
VALUES
  (1, 1, 2),
  (1, 2, 2),
  (1, 3, 2),
  (2, 1, 1),
  (2, 2, 1),
  (2, 3, 1),
  (3, 3, 3),
  (3, 4, 2);

select u.id as "user.id", u.name, u.email, o.id as "order.id", o.shipping_address, o.user_id 
from users as u
join orders o 
on u.id = o.user_id;

select * from users u
join orders o
on u.id = o.user_id
join line_items li
on li.order_id = o.id
join products p
on li.product_id = p.id; 

select * from orders o
left join line_items li
on li.order_id = o.id;
 
select * from line_items li
right join orders o 
on li.order_id = o.id
where li.id is null;

ALTER TABLE products add column description TEXT not null default 'description';

alter table products drop column description;

select * from products;

alter table store_users add COLUMN orderid int;

alter table store_orders add column userid int;