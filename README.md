# AirCargo-Analysis-using-SQL

**DESCRIPTION:** Air Cargo is an aviation company that provides air transportation services for passengers and freight. Air Cargo uses its aircraft to provide different services with the help of partnerships or alliances with other airlines. The company wants to prepare reports on regular passengers, busiest routes, ticket sales details, and other scenarios to improve the ease of travel and booking for customers.

**PROBLEM STATEMENT:** As a DBA expert, I need to focus on identifying the regular customers to provide offers, analyze the busiest route which helps to increase the number of aircraft required and prepare an analysis to determine the ticket sales details. This will ensure that the company improves its operability and becomes more customer-centric and a favorable choice for air travel.

This project includes almost all the concepts of SQL like **Stored Procedure, Window functions, roll up function, group by and having clause, order by  clause, IF and CASE, Joins, use of constraints like primary key, foreign key, creating ER diagram etc. **

This project contains 4 tables, whose data description is given below:

Dataset description:

Customer: Contains the information of customers

•	customer_id – ID of the customer

•	first_name – First name of the customer

•	last_name – Last name of the customer 

•	date_of_birth – Date of birth of the customer

•	gender – Gender of the customer
 
passengers_on_flights: Contains information about the travel details

•	aircraft_id – ID of each aircraft in a brand

•	route_id – Route ID of from and to location

•	customer_id – ID of the customer

•	depart – Departure place from the airport

•	arrival – Arrival place in the airport

•	seat_num – Unique seat number for each passenger

•	class_id – ID of travel class

•	travel_date – Travel date of each passenger

•	flight_num – Specific flight number for each route

 
 
ticket_details: Contains information about the ticket details

•	p_date – Ticket purchase date

•	customer_id – ID of the customer

•	aircraft_id – ID of each aircraft in a brand

•	class_id – ID of travel class

•	no_of_tickets – Number of tickets purchased

•	a_code – Code of each airport

•	price_per_ticket – Price of a ticket

•	brand – Aviation service provider for each aircraft

 
routes: Contains information about the route details

•	Route_id – Route ID of from and to location

•	Flight_num – Specific fight number for each route

•	Origin_airport – Departure location

•	Destination_airport – Arrival location

•	Aircraft_id – ID of each aircraft in a brand

•	Distance_miles – Distance between departure and arrival location



TASKS PERFORMED:

This project involved an analysis of an air cargo company's database, focusing on various aspects such as entity-relationship modeling, database querying, stored procedure creation, and data extraction. 

The key tasks performed throughout the project are as follows:

1.	Created an ER diagram to visualize the relationships within the airlines database, helping to understand the structure of the data.

2.	Designed a query to create the route_details table, considering appropriate data types for fields such as route ID, flight number, origin airport, destination airport, aircraft ID, and distance in miles. Implemented check and unique constraints for flight numbers and route IDs, respectively, and ensured the distance in miles is greater than 0.

3.	Wrote a query to display all the passengers who traveled on routes 01 to 25, retrieving data from the passengers_on_flights table.

4.	Developed a query to identify the number of passengers and total revenue in the business class from the ticket_details table.

5.	Constructed a query to display the full name of the customers by extracting the first name and last name from the customer table.

6.	Formulated a query to extract the customers who have registered and booked a ticket, utilizing data from the customer and ticket_details tables.

7.	Created a query to identify the customer's first name and last name based on their customer ID and brand (specifically, Emirates) from the ticket_details table.

8.	Utilized the Group By and Having clauses to write a query that identifies the customers who have traveled by the Economy Plus class, leveraging the passengers_on_flights table.

9.	Implemented an IF clause within a query to identify whether the revenue has exceeded 10,000, examining the ticket_details table.

10.	Developed a query to create and grant access to a new user, allowing them to perform operations on the database.

11.	Utilized window functions in a query to determine the maximum ticket price for each class from the ticket_details table.

12.	Optimized the performance of a query to extract passengers with a specific route ID (4) from the passengers_on_flights table.

13.	Created a query to view the execution plan of the passengers_on_flights table for the specified route ID (4).

14.	Developed a query using the rollup function to calculate the total price of all tickets booked by a customer across different aircraft IDs.

15.	Created a view containing only business class customers along with the brand of airlines.

16.	Designed a stored procedure to retrieve details of all passengers flying between a range of routes.

17.	Developed a stored procedure to extract details from the routes table where the traveled distance is more than 2000 miles.

18.	Created a stored procedure to group the distance traveled by each flight into three categories: short distance travel (SDT), intermediate distance travel (IDT), and long-distance travel (LDT).

19.	Utilized a stored function within a stored procedure to extract the ticket purchase date, customer ID, class ID, and information on whether complimentary services are provided based on the specific class.

**The screenshot of the output of all the tasks has been pasted after every tasks performed and can be referred from the pdf file uploaded.
**

HAPPY ANALYZING !!!

