create database aviation;
use aviation;

# Since none of the table have primary key, so lets define it before joining the table using foreign key

# In customer table the primary key is customer_id, in routes table the primary key is route_id. Lets alter the table and add the primary keys respectively
# But the tables passengsonflight and ticketdetails do not have specific column for primary key.
# So I shall join all the tables based on the above details.

ALTER TABLE customer
ADD CONSTRAINT pk PRIMARY KEY(customer_id);

ALTER TABLE routes
ADD CONSTRAINT pk1 PRIMARY KEY(route_id);

ALTER TABLE passengersonflight
ADD CONSTRAINT fk FOREIGN KEY(customer_id)
REFERENCES customer(customer_id);

ALTER TABLE ticketdetails
ADD CONSTRAINT fk1 FOREIGN KEY(customer_id)
REFERENCES customer(customer_id);

ALTER TABLE passengersonflight
ADD CONSTRAINT fk2 FOREIGN KEY(route_id)
REFERENCES routes(route_id);

# Write a query to create route_details table using suitable data types for the fields, such as route_id, flight_num, origin_airport, destination_airport, aircraft_id, and distance_miles. Implement the check constraint for the flight number and unique constraint for the route_id fields. Also, make sure that the distance miles field is greater than 0.

select * from routes;

# Implement the check constraint for the flight number 
alter table routes 
add constraint c
CHECK (flight_num between 1111 and 1160);

# Implementing unique constraint for the route_id fields
ALTER TABLE routes
add constraint u
UNIQUE(flight_num);

# Also, make sure that the distance miles field is greater than 0

SELECT *
FROM routes
WHERE distance_miles <= 0;

alter table routes 
add constraint c1
CHECK (distance_miles > 0);

# Write a query to display all the passengers (customers) who have travelled in routes 01 to 25

select * from customer;
select * from routes;
select * from passengersonflight;

select c1.customer_id, c1.first_name, c1.last_name, pof.route_id
from customer c1, passengersonflight pof
where route_id between 1 AND 25
order by route_id;

# Write a query to identify the number of passengers and total revenue in business class from the ticket_details table.
select * from ticketdetails;

select sum(no_of_tickets) as 'TotalPassenger', sum(no_of_tickets * Price_per_ticket) as 'TotalRevenue'
from ticketdetails 
WHERE class_id= 'Bussiness';

# Write a query to display the full name of the customer by extracting the first name and last name from the customer table.

select CONCAT(first_name,' ',last_name) AS NAME
from customer;

# Write a query to extract the customers who have registered and booked a ticket. Use data from the customer and ticket_details tables.
select c2.customer_id, CONCAT(c2.first_name,' ',c2.last_name) AS 'NAME', COUNT(t2.no_of_tickets) AS "TicketsBooked"
from customer c2
JOIN ticketdetails t2 USING(customer_id)
GROUP BY c2.customer_id, NAME
order by TicketsBooked desc;

# Write a query to identify the customer’s first name and last name based on their customer ID and brand (Emirates) from the ticket_details table.

select * from ticketdetails;

select c3.customer_id, c3.first_name,c3.last_name,t3.brand
from customer c3
JOIN ticketdetails t3 USING(customer_id)
WHERE t3.brand='Emirates'
ORDER BY c3.customer_id;

# Write a query to identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table.
select * from passengersonflight;

select c4.customer_id, c4.first_name,c4.last_name
from customer c4
JOIN passengersonflight p4  USING(customer_id)
GROUP BY c4.customer_id, c4.first_name,c4.last_name
HAVING SUM(p4.class_id="Economy Plus")>0;

#  Write a query to identify whether the revenue has crossed 10000 using the IF clause on the ticket_details table.

select if(sum(no_of_tickets*Price_per_ticket)>10000,'Revenue Crosses 10000', 'Revenue less than 10000') AS 'REVENUE STATUS'
from ticketdetails;

# Write a query to create and grant access to a new user to perform operations on a database.

CREATE USER new_user IDENTIFIED by 'new123';
GRANT ALL PRIVILEGES ON  aviation .* TO new_user;
FLUSH privileges;

# Write a query to find the maximum ticket price for each class using window functions on the ticket_details table.

select *,
MAX(Price_per_ticket) OVER (partition by class_id) AS MAX_TICKET_PRICE
from ticketdetails;

# Write a query to extract the passengers whose route ID is 4 by improving the speed and performance of the passengers_on_flights table.
select * from passengersonflight
WHERE route_id=4;

# Write a query to calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.

select p5.customer_id,p5.aircraft_id, sum(t5.no_of_tickets * t5.Price_per_ticket) AS "Total Price"
from passengersonflight p5
JOIN ticketdetails t5 using(customer_id)
GROUP BY p5.customer_id,p5.aircraft_id WITH ROLLUP;

# Write a query to create a view with only business class customers along with the brand of airlines.

select customer_id, brand
from ticketdetails
WHERE class_id='Bussiness';

# Write a query to create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.

DELIMITER &&
CREATE PROCEDURE getAllDetails(IN start_route int, IN end_route int)
BEGIN
	select * from passengersonflight
    WHERE route_id BETWEEN start_route AND end_route;
END &&
DELIMITER ;
CALL getAllDetails(1,14);

# Write a query to create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.

DELIMITER &&
CREATE PROCEDURE getAllRoutes()
BEGIN
	select * from routes
    WHERE distance_miles >2000;
END &&
DELIMITER ;
CALL getAllRoutes();

# Write a query to create a stored procedure that groups the distance travelled by each flight into three categories. The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500.

DELIMITER &&
CREATE PROCEDURE getCategories()
BEGIN
	select flight_num,distance_miles,
    CASE
		WHEN distance_miles BETWEEN 0 AND 2000 THEN  "Short Distance"
		WHEN distance_miles BETWEEN 2001 AND 6500 THEN  "Intermediate"
		ELSE "Long Distance"
    END AS "Category"
    from routes;
END &&
DELIMITER ;
CALL getCategories();

# Write a query to extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific class using a stored function in stored procedure on the ticket_details table.
# Condition: If the class is Business and Economy Plus, then complimentary services are given as Yes, else it is No

DELIMITER &&
CREATE PROCEDURE getComplementaryServiceDetails()
BEGIN
select p_date,customer_id,class_id,
CASE
	WHEN class_id = "Bussiness"  THEN "YES"
    WHEN class_id = "Economy Plus"  THEN "YES"
    ELSE "NO"
END AS "Complimentary Services"
from ticketdetails;
END &&
DELIMITER ;

CALL getComplementaryServiceDetails();

# Write a query to extract the first record of the customer whose last name ends with Scott using a cursor from the customer table.

select * from customer
where last_name = 'Scott'
LIMIT 1;
