select * from invoiceline where unitprice>0.99;

select i.invoicedate, i.total, c.firstname, c.lastname from invoice i
join customer c on i.customerid = c.customerid;

select c.firstname, c.lastname, e.firstname, e.lastname from customer c
join employee e on e.employeeid = c.supportrepid;

select a.title, b.name from album a
join artist b on b.artistid = a.artistid;

select a.trackid from playlisttrack a
join playlist b on b.playlistid = a.playlistid where b.name = "Music";

select t.name from track t
join playlisttrack p on p.trackid = t.trackid where p.playlistid = 5;

select t.name, p.name from track t
join playlisttrack pt on t.trackid = pt.trackid
join playlist p on p.playlistid = pt.playlistid;

select t.name, a.title from track t 
join genre g on g.genreid = t.genreid 
join album a on a.albumid = t.albumid
where g.name = "Alternative";

-- BLACK DIAMOND
select t.name, g.name, a.title, ar.name from playlist p
join playlisttrack pt on p.playlistid = pt.playlistid
join track t on pt.trackid = t.trackid
join genre g on g.genreid = t.genreid
join album a on a.albumid = t.albumid
join artist ar on ar.artistid = a.artistid
where p.name = "Music";
-- /BLACK DIAMOND

select * from invoice where invoiceid in (select invoiceid from invoiceline where unitprice > 0.99);

select * from playlisttrack
where playlistid in (select playlistid from playlist where name = "Music");

select name from track
where trackid in (select trackid from playlisttrack where playlistid = 5);

select * from track
where genreid in (select genreid from genre where name = "Comedy");

select * from track
where albumid in (select albumid from album where title = "Fireball");

select * from track
where albumid 
in (select albumid from album where artistid 
    in (select artistid from artist where name = "Queen"));

update customer
set fax = null
where fax is not null;

update customer
set company = "Self"
where company is null;

update customer
set lastname = "Thompson"
where firstname = "Julia" and lastname = "Barnett";

update customer
set supportrepid = 4
where email = "luisrojas@yahoo.cl";

update track
set composer = "The darkness around us"
where composer is null and
genreid = (select genreid from genre where name = "Metal");

select g.name, count(t.name) from genre g
join track t on t.genreid = g.genreid
group by g.name;

select count(*), g.name from genre g
join track t on t.genreid = g.genreid
where g.name = "Pop" or g.name = "Rock"
group by g.name;

SELECT ar.name, count(*) from album a
join artist ar on ar.artistid = a.artistid
group by name;

select distinct composer from track;

select distinct billingpostalcode from invoice;

select distinct company from customer;

CREATE TABLE practice_delete ( Name string, Type string, Value integer );
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "bronze", 50);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "silver", 100);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);
INSERT INTO practice_delete ( Name, Type, Value ) VALUES ("delete", "gold", 150);

SELECT * FROM practice_delete;

delete from practice_delete where type = "bronze";

delete from practice_delete where type = "silver";

delete from practice_delete where value is 150;

create table store_users (UserId serial primary key, Name text, Email text unique);
insert into store_users (Name, Email)
values ('Freeple', 'freep@pl.com');
insert into store_users (Name, Email)
values ('Zoobar', 'steamypoo@yummy.com');
insert into store_users (Name, Email)
values ('Leapzy', 'nodb@argo.com');

create table store_products (ProductId serial primary key, Name text, Price decimal);
insert into store_products (Name, Price)
values ('Yumster', 399.99);
insert into store_products (Name, Price)
values ('Creepy Spiegel', 19.99);
insert into store_products (Name, Price)
values ('Olofs Eartone', 57.99);

create table store_orders (OrderId serial primary key, ProductId references store_producs(ProductId));
insert into store_orders (ProductId)
values (1);
insert into store_orders (ProductId)
values (2);
insert into store_orders (ProductId)
values (1);

select * from store_products
where productid in (select productid from store_orders where orderid = 1);

select sum(p.price) from store_orders o
join store_products p on o.productid = p.productid
where o.orderid = 2;

alter table store_users add COLUMN orderid references store_orders(orderid);

alter table store_orders add column userid references store_users(userid);
update store_orders
set productid = 3
where orderid = 4;

select * from store_orders
where userid in (select userid from store_users where userid = 3);

select name, count(*) from store_users u
group by u.name;

select u.name, sum(p.price) from store_products p
join store_orders o on p.productid = o.productid
join store_users u on u.orderid = o.orderid
group by u.name;

