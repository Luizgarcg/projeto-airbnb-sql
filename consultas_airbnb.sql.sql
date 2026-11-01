select * from listings limit 20;
select name,neighbourhood,room_type,price from listings where neighbourhood = 'copacabana' limit 20;
select name,neighbourhood,room_type,price from listings order by price desc limit 10;
select count(name) ,avg(price) from listings;
select neighbourhood, count(name), avg(price) from listings group by neighbourhood order by avg(price) desc limit 10;
select room_type, count(name), avg(price) from listings group by room_type order by avg(price) desc;
select listings.name, reviews.comments from listings join reviews on listings.id = listing_id limit 5;
select listings.neighbourhood, count(reviews.comments) from listings join reviews on listings.id = listing_id group by listings.neighbourhood order by count(reviews.comments) desc limit 10;
