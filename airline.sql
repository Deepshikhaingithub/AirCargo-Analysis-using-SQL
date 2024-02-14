create database aviation;
use aviation;
select * from passengersonflight;
select * from customer;
select * from routes;
select * from ticketdetails;

alter table customer add constraint pk primary key(customer_id);
alter table routes add constraint pk1 primary key(route_id);
alter table passengersonflight add constraint fk foreign key(customer_id) references customer(customer_id);
alter table ticketdetails add constraint fk1 foreign key(customer_id) references customer(customer_id);
alter table passengersonflight add constraint fk2 foreign key(route_id) references routes(route_id);

select count(customer_id) FROM aviation.passengersonflight;

# Lets first identify the types of aircraft we have and how many passengers are travelling.

SELECT aircraft_id, sum(no_of_tickets) as 'total ticket' FROM aviation.ticketdetails
group by aircraft_id
order by 'total ticket' DESC;

/* From the above we can see that there are 4 types of aircraft:
 1. Airbus A321- a commercial aircraft
 2. Boeing 767-301ER- a commercial aircraft
 3. Embraer ERJ142 - a regional jet (capacity 42)
 4. Bombardier CRJ900 -na regional jet (capactity-80-90)
 
 And Maximum passengers are travelling with Boeing 767-301ER i.e out of 50 passengers, 18 passengers travelled through Boeing.
 */

# Let us identify the no. of passengers and total revenue earned by each Aircraft as per their class-id
select aircraft_id, class_id,count(customer_id) as passengers, sum(no_of_tickets* Price_per_ticket) as revenue
from ticketdetails
group by aircraft_id, class_id
order by revenue desc;

/* Identifying the Customer Segmentation and Preferences:

--Understanding the demographics of customers and their travel preferences.
--Identifying patterns in gender and travel class preferences. */

SELECT 
    c.gender, t.class_id,
    COUNT(c.customer_id) as customer_count,
    AVG(t.Price_per_ticket) as avg_ticket_price
FROM customer c
JOIN ticketdetails t
ON c.customer_id = t.customer_id
GROUP BY c.gender,t.class_id
order by gender DESC; 

/* Inferences Drawn:
	-- Out of 50 passengers, 30 are male and 20 female.
	-- The count is highest for Male customers in the Business class, suggesting that more males booked tickets in the Business class compared to other classes.*/

/*Flight Route Optimization:

-- Determing the busiest Airport
  # 1. Departure Airport
  
SELECT
    origin_airport,
    COUNT(*) as departure_count
FROM routes
GROUP BY origin_airport
ORDER BY departure_count DESC;

/* Inferences Drawn:
	1. Busiest Origin Airports:
		--HNL (Honolulu International Airport): It appears to be the busiest origin airport with 3 departures, suggesting a high demand for flights departing from Honolulu.
		--EWR (Newark Liberty International Airport): It has 2 departures, indicating a relatively busy airport for flight departures.
		--LAX (Los Angeles International Airport): Similarly, LAX has 2 departures, showing significant departure activity.
        
	2.Limited Departures from Some Airports:
		--Several airports, including JFK, ORD, DEN, ABI, ADK, BQN, CAK, ALB, APN, ANI, ATW, AVL, BFL, BGR, BLV, BJI, RDM, BET, and others, have only 1 departure each.
		--This may indicate that these airports have relatively lower departure frequencies in the given dataset.
        
	3.Potential Hub Airports:
		--HNL, with the highest departure count, might be a significant hub or a popular starting point for flights in the context of this dataset.*/

#. 2. Destination Airport

select destination_airport, count(*) as frequency
from routes
group by destination_airport
order by frequency DESC;

/* Inferences Drawn:
	1. Most Common Destination Airports:
		--LAX (Los Angeles International Airport): It is the most frequently occurring destination airport with 4 flights in the dataset, indicating a high demand for flights arriving at Los Angeles.
		--EWR (Newark Liberty International Airport): EWR follows closely with 3 flights as the destination, suggesting significant arrival activity.*/
 
# Routes - Longest and shortest 
SELECT route_id, origin_airport, destination_airport,distance_miles
FROM routes
GROUP BY route_id, origin_airport, destination_airport, distance_miles
ORDER BY distance_miles DESC;

/* Inferences Drawn:
	1. Longest Routes:
		--The routes with the highest distances are at the top, such as route_id 43 from CBM to BOI with 8989 miles and route_id 46 from CDV to HNL with 8668 miles.
		-- These long-distance routes might involve intercontinental flights.
        
	2. Shorter Routes:
		-- Some routes have shorter distances, like route_id 32 from CLD to CHI (246 miles), route_id 28 from BOS to CDC (246 miles), and route_id 27 from BOI to CLD (578 miles).
		-- Shorter routes are typically domestic flights or flights within a continent.

/*Revenue Management:

--Optimizing pricing strategies based on historical ticket sales and customer preferences.
-- Identifying the most profitable travel classes.*/

SELECT 
    class_id,
    COUNT(*) as tickets_sold,
    AVG(Price_per_ticket) as avg_ticket_price,
    SUM(Price_per_ticket) as total_revenue
FROM ticketdetails
GROUP BY class_id
order by total_revenue DESC;

/* Inferences Drawn : 
   1. Ticket Sales by Class:
		-- "Economy" class has the highest number of ticket sales (14), indicating that it is a popular choice among passengers.
		-- "Economy Plus","First Class" and "Bussiness" classes have 10 and 13 ticket sales, respectively, suggesting a moderate level of demand.
	
   2. Total Revenue:
		-- "Bussiness" class generates the highest total revenue ($6034), primarily due to its higher average ticket prices.
		-- "First Class" follows with a total revenue of $4885.
		-- "Economy Plus" generates $2460 in total revenue, while "Economy" generates $1990.
        
	3. Pricing Strategy Considerations:
		-- The higher average ticket prices in premium classes ("Bussiness" and "First Class") contribute significantly to the overall revenue. Consider maintaining or optimizing pricing strategies for these classes to maximize revenue.
		-- "Economy" class, while having a lower average ticket price, contributes to a substantial number of ticket sales. Adjusting pricing or promotions in this class may attract more budget-conscious passengers.
*/

# Yearly Revenue Trend:

SELECT 
    DATE_FORMAT(STR_TO_DATE(p_date, '%m/%d/%Y'), '%Y') AS year,
    SUM(Price_per_ticket * no_of_tickets) AS total_revenue
FROM 
    ticketdetails
GROUP BY 
    year
ORDER BY 
    total_revenue desc;

/* Infereences Drawn:
	1. Revenue Growth:
		--There is an apparent increase in revenue from 2018 to 2019, and further growth from 2019 to 2020. 
        --This indicates positive business performance and increasing ticket sales over the years.*/
    
    
# Year-wise Monthy Revenue 
    
SELECT 
    YEAR(STR_TO_DATE(p_date, '%m/%d/%Y')) AS year,
    MONTHNAME(STR_TO_DATE(p_date, '%m/%d/%Y')) AS month,
    SUM(Price_per_ticket * no_of_tickets) AS monthly_revenue
FROM 
    ticketdetails
GROUP BY 
    year, month
ORDER BY 
    year DESC, monthly_revenue DESC;
    
/* Inferences Drwan:
	1. 2020 Monthly Revenue Analysis:
		--The highest monthly revenue in 2020 is observed in March (980), followed by November (930) and July (860).
		--December has the lowest monthly revenue in 2020 (675).
	2.2019 Monthly Revenue Analysis:
		--January stands out as the month with the highest revenue in 2019 (1690), followed by March (499) and July (480).
		--September and February have the lowest monthly revenues in 2019 (150 and 120, respectively).
	3. 2018 Monthly Revenue Analysis:
		--April has the highest monthly revenue in 2018 (510), followed by December, July, and November (all with 430).
		--February and September have the lowest monthly revenues in 2018 (100 and 130, respectively).
	4. Seasonal Trends:
		-- March and November seem to be strong months across all years.
	5. Business Planning:
		--We can plan marketing and promotional activities during high-revenue months. For instance, March and November may be months to focus on promotions or events.
	6. Identifying Challenges:
		-- Low-revenue months can be explored to identify challenges or opportunities for improvement. For example, if certain months consistently have lower revenue, it might be worth investigating potential causes.
*/

# Now, lets extract few information for further analysis using concepts of Window function, Roll up function, Stored Procedure etc.

# Number of tickets booked by Passengers

select c2.customer_id, CONCAT(c2.first_name,' ',c2.last_name) AS 'NAME', COUNT(t2.no_of_tickets) AS "TicketsBooked"
from customer c2
JOIN ticketdetails t2 USING(customer_id)
GROUP BY c2.customer_id, NAME
order by TicketsBooked desc;

/* Inferences Drawn: 
	--Roger Walson, Joyce Paul, and Aaron Kim have booked the maximum number of tickets (3 each).
    --Businesses could consider identifying customers with consistent high-ticket bookings for potential VIP programs or special offers to encourage continued engagement
*/


# Lets identify the customers who have travelled by Economy Plus class using Group By and Having clause on the passengers_on_flights table.

select c4.customer_id, CONCAT(c4.first_name,' ',c4.last_name) as Passenger_name
from customer c4
JOIN passengersonflight p4  USING(customer_id)
GROUP BY c4.customer_id, Passenger_name
HAVING SUM(p4.class_id="Bussiness")>0;

/* Inference Drawn: 
	11 passengers were travelling by Bussiness class. So, Businesses could consider providing complementary services in order to retain the passengers.*/
    

# Lets find the maximum ticket price for each class using window functions on the ticket_details table.

select *,
MAX(Price_per_ticket) OVER (partition by class_id) AS MAX_TICKET_PRICE
from ticketdetails;

/* Inference Drawn:
 1. Price Variation Across Classes:
		--Different travel classes ("Economy," "Economy Plus,", "First Class" and "Bussiness") have distinct maximum ticket prices.
		--Bussiness Class tickets have the highest maximum price (510), followed by, First Class, Economy Plus and Economy classes.*/
        

# Lets calculate the total price of all tickets booked by a customer across different aircraft IDs using rollup function.

select p5.customer_id,p5.aircraft_id, sum(t5.no_of_tickets * t5.Price_per_ticket) AS "Total Price"
from passengersonflight p5
JOIN ticketdetails t5 using(customer_id)
GROUP BY p5.customer_id,p5.aircraft_id WITH ROLLUP;


# Lets create a stored procedure to get the details of all passengers flying between a range of routes defined in run time.

DELIMITER &&
CREATE PROCEDURE getAllDetails(IN start_route int, IN end_route int)
BEGIN
	select * from passengersonflight
    WHERE route_id BETWEEN start_route AND end_route;
END &&
DELIMITER ;
CALL getAllDetails(1,14);

# Lets create a stored procedure that extracts all the details from the routes table where the travelled distance is more than 2000 miles.

DELIMITER &&
CREATE PROCEDURE getAllRoutes()
BEGIN
	select * from routes
    WHERE distance_miles >2000;
END &&
DELIMITER ;
CALL getAllRoutes();

# Lets create a stored procedure that groups the distance travelled by each flight into three categories. The categories are, short distance travel (SDT) for >=0 AND <= 2000 miles, intermediate distance travel (IDT) for >2000 AND <=6500, and long-distance travel (LDT) for >6500.

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

# Lets extract ticket purchase date, customer ID, class ID and specify if the complimentary services are provided for the specific class using a stored function in stored procedure on the ticket_details table.
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

