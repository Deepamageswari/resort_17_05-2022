select * from resort1;
select * from customer2;
select * from reservation;
select * from reservation_line;
select * from service;
select * from service_line;
select * from age_group;
select * from city2;
select * from region;
select * from country1;
--Find out the resorts where both customer ‘Tim’and customer ‘Bill’ stayed.
insert into reservation_line values(3,15,90008,70003);
update  city set region_id=30003 where city_id=30; 
select re.resort,c.first_name from customer2 c 
inner join reservation r on c.cust_id=r.cust_id
inner join reservation_line l on r.res_id=l.res_id
inner join service s on s.service_id=l.service_id
inner join service_line sl on sl.sl_id=s.sl_id
inner join resort1 re on re.resort_id=sl.resort_id where first_name in ('tim','bill');
--Find out the services which are available in the resort ‘Taj Club’ but not in ‘Taj Metro’
select s.service_name,re.resort,sl.sl_id from service s 
inner join service_line sl on s.sl_id=sl.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
where re.resort ='taj Club' and s.service_name not in 
(select s.service_name from service s 
inner join service_line sl on s.sl_id=sl.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
where re.resort ='taj Metro');
--Display customer name, age group, city, regionand country who has reserved ‘Boat services’
insert into service values(70009,'Boat service',50000,60002);
alter table city add region_id int;
select c.first_name,a.age_group_id,ct.city,rg.region,co.country,s.service_name from customer2 c 
inner join age_group a on a.age_group_id=c.age_group_id
inner join city2 ct on c.city_id=ct.city_id
inner join region rg on rg.region_id=ct.region_id
inner join country1 co on co.country_id=rg.country_id
inner join reservation r on c.cust_id=r.cust_id
inner join reservation_line l on r.res_id=l.res_id
inner join service s on s.service_id=l.service_id
inner join service_line sl on sl.sl_id=s.sl_id
where s.service_name='buffet service';
--Write a query to find customers who areaged between 60 and 70 and who havereservation in the next month in India resorts.
update reservation_line set service_id=70004 where res_id=90008;
insert into reservation values(90008,'12-JUN-22',80004);
select c.first_name||' '||c.last_name name,ag.age_group_id from customer2 c 
inner join age_group ag on c.age_group_id=ag.age_group_id
inner join reservation r on c.cust_id=r.cust_id
inner join reservation_line l on r.res_id=l.res_id
inner join service s on s.service_id=l.service_id
inner join service_line sl on sl.sl_id=s.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
where ag.age_group_id=10004  and to_char(r.res_date,'mon-yyyy')=to_char(sysdate+25,'mon-yyyy') and re.country_id=20001;
--Display the regions where we have more than 10 cities.
select region from region 
where region_id in 
( select region_id from city2 group by region_id having count(city)>5);
--customer count.Display age group wise
select count(cust_id) from customer2 group by age_group_id;
--Display resort_name, resort_country, customer_name and customer_country based onthe reservations table.
select re.resort,re.country_id,c.first_name,co.country  from customer2 c
inner join reservation r on c.cust_id=r.cust_id
inner join reservation_line l on r.res_id=l.res_id
inner join service s on s.service_id=l.service_id
inner join service_line sl on sl.sl_id=s.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
inner join age_group a on a.age_group_id=c.age_group_id
inner join city2 ct on c.city_id=ct.city_id
inner join region rg on rg.region_id=ct.region_id
inner join country1 co on co.country_id=rg.country_id;
--What is the costliest service in each service_line?
select service_name,service_id,price from service where price in (select max(price) from service group by sl_id);
--Display the result which displays service_name,price, maximum_price with in the service line.
--previous query
--Display country_name, number of regions andnumber of cities for each country.
select country,count(c.region_id),count(c.city_id) from city2 c,country1 ct,region r
where ct.country_id=r.country_id
and r.region_id=c.region_id
group by country;
--Display the number of reservations we have basedon each resort.
select re.resort,count(r.res_id) from reservation r
inner join reservation_line l on r.res_id=l.res_id
inner join service s on s.service_id=l.service_id
inner join service_line sl on sl.sl_id=s.sl_id
inner join resort1 re on re.resort_id=sl.resort_id
group by re.resort;








